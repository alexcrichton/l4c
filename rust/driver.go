package main

import "bufio"
import "bytes"
import "flag"
import "fmt"
import "github.com/cheggaaa/pb"
import "github.com/wsxiaoys/terminal"
import "io/ioutil"
import "os"
import "os/exec"
import "path/filepath"
import "regexp"
import "strconv"
import "strings"
import "sync"
import "syscall"
import "time"

const MakeTimeout = time.Minute
const CompilerTimeout = 5 * time.Second
const TestTimeout = 5 * time.Second
const GccTimeout = 2 * time.Second
const Compiler = "./bin/l4c"
const LogDirectory = "../log"
const Runtime = "l4rt.c"
var TestPattern = regexp.MustCompile(`//test (\w+)(?: (-?\w+))?`)

const RESET = "\x1b[0m"
const BOLD = "\x1b[;1m"
const RED = "\x1b[31m"
const GREEN = "\x1b[32m"

var Parallel = 8
var Verbose = false
var Progress = true
var FailFast = false
var Color = true

type TestKind int

type Directive struct {
  Kind TestKind
  Code int
  Safe bool
}

type Test struct {
  Directive
  File string
  Extra string
  Passed bool
}

const (
  Error TestKind = iota
  Return
  Exception
)

var log chan Test
var failFast chan int

func main() {
  flag.BoolVar(&Color, "color", true, "print pass/fail in colors")
  flag.IntVar(&Parallel, "parallel", 1, "amount of tests to parallelize")
  flag.BoolVar(&Progress, "progress", true, "show a progress bar")
  flag.BoolVar(&FailFast, "failfast", false, "stop once one test fails")
  flag.BoolVar(&Verbose, "verbose", false, "print more output of tests")

  read := flag.String("testfile", "", "file to read tests from")
  write := flag.String("failurefile", "", "file to write failed tests to")
  retest := flag.String("retest", "", "file to read tests from and write failures to")

  flag.Parse()
  if *read == "" { *read = *retest }
  if *write == "" { *write = *retest }

  build_compiler()
  log = make(chan Test)
  failFast = make(chan int, 1)

  tests := flag.Args()
  if *read != "" {
    tests = make([]string, 0)
    file, err := os.Open(*read)
    check(err)
    in := bufio.NewReader(file)
    for {
      test, err := in.ReadString('\n')
      if err != nil { break }
      tests = append(tests, test[:len(test)-1])
    }
    file.Close()
  }

  failed := runTests(tests)

  if *write != "" {
    file, err := os.Create(*write)
    check(err)
    for _, s := range failed {
      fmt.Fprintf(file, "%s\n", s)
    }
    file.Close()
  }
}

func runTests(files []string) []string {
  tests := make(chan string)
  var completions sync.WaitGroup

  /* Spawn off workers to run tests */
  for i := 0; i < Parallel; i++ {
    go func() {
      for test := range tests {
        run_test(test)
      }
    }()
  }

  /* One worker adds all the tests to the queue, closing channels when
     everything has completely finished */
  go func() {
    for _, f := range files {
      completions.Add(1)
      select {
        case tests <- f:
        case <-failFast:
          completions.Done()
          goto done
      }
    }
    /* clean up everything now */
    done:
    completions.Wait()
    close(tests)
    close(log)
  }()

  bar := pb.StartNew(len(files))
  pb.Empty = " "
  passed := 0
  failed := make([]string, 0)
  for t := range log {
    if Progress {
      print("\r")
      terminal.Stdout.ClearLine()
    }
    println(t.text())
    if Progress {
      bar.Increment()
    }
    completions.Done()
    if t.Passed {
      passed += 1
    } else {
      failed = append(failed, t.File)
      if FailFast {
        return failed
      }
    }
  }
  fmt.Printf("Passed %d/%d tests\n", passed, len(files))
  return failed
}

func build_compiler() {
  println("-- Building compiler --")
  cmd := exec.Command("make")
  cmd.Stdout = os.Stdout
  cmd.Stderr = os.Stderr
  cmd.Stdin = nil
  run(cmd, MakeTimeout)
  if !cmd.ProcessState.Success() {
    println("error: make did not succeed")
    os.Exit(1)
  }
}

func run_test(testfile string) {
  var stdout bytes.Buffer
  var stderr bytes.Buffer
  var test Test
  test.File = testfile
  var cmd *exec.Cmd
  defer func() { log <- test }()

  test.Extra = test.Directive.parse(testfile)
  if test.Extra != "" {
    return
  }
  assembly := withext(testfile, ".s")
  executable := withext(testfile, "-" + filepath.Ext(testfile)[1:])

  fail := func(msg string) {
    if Verbose {
      msg += "\n  cmd: "
      for _, arg := range cmd.Args {
        msg += arg + " "
      }
      if stdout.String() != "" {
        msg += "\n  stdout:\n" + tab(stdout.String())
      }
      if stderr.String() != "" {
        msg += "\n  stderr:\n" + RED + tab(stderr.String()) + RESET
      }
    }
    test.Extra = msg
  }

  /* Run the compiler on the specified test */
  if test.Safe {
    cmd = exec.Command(Compiler, "--safe", "-l", "l4rt.h0", testfile)
  } else {
    cmd = exec.Command(Compiler, "--unsafe", "-l", "l4rt.h0", testfile)
  }
  cmd.Stdout = &stdout
  cmd.Stderr = &stderr
  cmd.Stdin = nil
  err := run(cmd, CompilerTimeout)
  defer os.Remove(assembly)
  if err != nil {
    fail("compiler timed out")
    return
  } else if test.Kind == Error {
    if !cmd.ProcessState.Success() {
      test.Passed = true
      return
    }
  } else if !cmd.ProcessState.Success() {
    fail("compiler failed and should not have failed")
    return
  }
  stdout.Reset()
  stderr.Reset()

  /* Next, run gcc on the generated assembly and the runtime */
  cmd = exec.Command("gcc", "-m64", "-o", executable, assembly, Runtime)
  cmd.Stdout = &stdout
  cmd.Stderr = &stderr
  cmd.Stdin = nil
  if run(cmd, GccTimeout) != nil {
    fail("gcc timed out")
    return
  } else if test.Kind == Error {
    if cmd.ProcessState.Success() {
      fail("compiler succeeded but should have failed")
    } else {
      test.Passed = true
    }
    return
  } else if !cmd.ProcessState.Success() {
    fail("gcc did not succeed")
    return
  }
  defer os.Remove(executable)

  /* Next, run the test itself */
  stdin, _ := os.Open(testfile + ".in") // if it doesn't exist, stdin == nil
  cmd = exec.Command(executable)
  cmd.Stdout = &stdout
  cmd.Stderr = &stderr
  cmd.Stdin = stdin
  err = run(cmd, TestTimeout)
  if stdin != nil {
    stdin.Close()
  }

  /* Finally, grade the results of the test */
  status := cmd.ProcessState.Sys().(syscall.WaitStatus)
  if test.Kind == Exception {
    if cmd.ProcessState.Success() || !status.Signaled() {
      fail("executable ran successfully")
    } else if test.Code == -1 ||
              (err != nil && test.Code == int(syscall.SIGALRM)) ||
              int(status.Signal()) == test.Code {
      test.Passed = true
    } else {
      fail(fmt.Sprintf("expected signal %d, got %d", test.Code,
                       status.Signal()))
    }
    return
  }
  if !cmd.ProcessState.Success() || err != nil {
    if err != nil {
      fail("test timed out")
    } else if status.Signaled() {
      fail(fmt.Sprintf("should have succeeded, received signal %d",
                       status.Signal()));
    } else {
      fail(fmt.Sprintf("should have succeeded, instead exited with %d",
                       status.ExitStatus()));
    }
    return
  }

  /* Test to make sure the return value is what we're supposed to get */
  ret, err := strconv.ParseInt(stdout.String(), 10, 32)
  if err != nil {
    fail("test should print out one integer when running to stdout")
    return
  } else if int(ret) != test.Code {
    stdout.Reset()
    fail(fmt.Sprintf("expected %d, got %d", test.Code, int(ret)))
    return
  }

  /* Next check the output is what we're expecting */
  actual := stderr.String()
  expected, err := os.Open(testfile + ".out")
  if err != nil {
    test.Passed = true
    return // no expected output file
  }
  defer expected.Close()
  bytes, err := ioutil.ReadAll(expected)
  check(err)
  if string(bytes) != actual {
    fail("output is not as expected")
  } else {
    test.Passed = true
  }
}

func check(err error) {
  if err != nil {
    panic(err)
  }
}

func run(c *exec.Cmd, timeout time.Duration) error {
  done := make(chan error)
  c.Start()
  go func() {
    done <- c.Wait()
  }()
  select {
    case <-done:
      return nil
    case <-time.After(timeout):
      c.Process.Kill()
  }
  return <-done
}

func withext(file, ext string) string {
  return file[:len(file)-len(filepath.Ext(file))] + ext
}

func (t *Test) text() string {
  if t.Passed {
    return BOLD + GREEN + "pass: " + RESET + t.File
  }
  return BOLD + RED + "fail: " + RESET + t.File + " - " + t.Extra
}

func (d *Directive) parse(file string) string {
  f, err := os.Open(file)
  defer f.Close()
  check(err)
  in := bufio.NewReader(f)
  line, err := in.ReadString('\n')
  check(err)
  matches := TestPattern.FindStringSubmatch(line)
  if matches == nil {
    return "no test directive found or invalid test directive"
  }
  matches = matches[1:]
  switch matches[0] {
    case "error":
      d.Kind = Error
    case "exception":
      d.Kind = Exception
    case "return":
      d.Kind = Return
      if len(matches) == 1 || matches[1] == "" {
        return "return directive requires a return value"
      }
  }
  d.Code = -1
  if len(matches) > 1 && matches[1] != "" {
    c, err := strconv.ParseInt(matches[1], 10, 32)
    if err != nil {
      return fmt.Sprintf("invalid code specified: '%s'", matches[1])
    }
    d.Code = int(c)
  }

  line, err = in.ReadString('\n')
  if err != nil && line == "//safe\n" {
    d.Safe = true
  }
  return ""
}

func tab(s string) string {
  return "    " + strings.Replace(s, "\n", "\n    ", -1)
}
