package main

import "strings"
import "fmt"
import "os"
import "os/exec"
import "syscall"
import "time"
import "sync"
import "bytes"
import "path/filepath"
import "bufio"
import "regexp"
import "strconv"
import "io/ioutil"

const MakeTimeout = time.Minute
const CompilerTimeout = 5 * time.Second
const TestTimeout = 1 * time.Second
const GccTimeout = 2 * time.Second
const Compiler = "./bin/l4c"
const LogDirectory = "../log"
const Runtime = "l4rt.c"
var TestPattern = regexp.MustCompile(`//test (\w+)(?: (-?\w+))?`)

var Parallel = 8
var Verbose = true

type TestKind int

type Directive struct {
  Kind TestKind
  Code int
  Safe bool
}

const (
  Error TestKind = iota
  Return
  Exception
)

var log chan string

func main() {
  build_compiler()
  log = make(chan string)

  files := os.Args[1:]

  tests := make(chan string)
  var completions sync.WaitGroup
  var logger sync.WaitGroup
  logger.Add(1)

  for i := 0; i < Parallel; i++ {
    go func() {
      for test := range tests {
        run_test(test)
        completions.Done()
      }
    }()
  }

  go func() {
    for s := range log {
      // TODO: progress bar
      println(s)
    }
    logger.Done()
  }()

  for _, f := range files {
    completions.Add(1)
    tests <- f
  }

  /* clean up everything now */
  completions.Wait()
  close(tests)
  close(log)
  logger.Wait()
}

func build_compiler() {
  println("-- Building compiler --")
  cmd := exec.Command("make")
  cmd.Stdout = os.Stdout
  cmd.Stderr = os.Stderr
  cmd.Stdin = nil
  run(cmd, MakeTimeout)
  if !cmd.ProcessState.Success() {
    fail("make did not succeed")
  }
}

func run_test(test string) {
  var stdout bytes.Buffer
  var stderr bytes.Buffer
  var directive Directive
  var cmd *exec.Cmd

  if !directive.parse(test) {
    return
  }

  fail := func(msg string) {
    if Verbose {
      msg += "\n  failed cmd: "
      for _, arg := range cmd.Args {
        msg += arg + " "
      }
      if stdout.String() != "" {
        msg += "\n  stdout:\n" + tab(stdout.String())
      }
      if stderr.String() != "" {
        msg += "\n  stderr:\n" + tab(stderr.String())
      }
    }
    failTest(test, msg)
  }

  pass := func() {
    log <- "pass: " + test
  }

  /* Run the compiler on the specified test */
  if directive.Safe {
    cmd = exec.Command(Compiler, "--safe", "-l", "l4rt.h0", test)
  } else {
    cmd = exec.Command(Compiler, "--unsafe", "-l", "l4rt.h0", test)
  }
  cmd.Stdout = &stdout
  cmd.Stderr = &stderr
  cmd.Stdin = nil
  if run(cmd, CompilerTimeout) != nil {
    fail("compiler timed out")
    return
  } else if directive.Kind == Error {
    if !cmd.ProcessState.Success() {
      pass()
      return
    }
    fail("compiler succeeded but should have failed")
    return
  } else if !cmd.ProcessState.Success() {
    fail("compiler failed and should not have failed")
    return
  }
  stdout.Reset()
  stderr.Reset()

  /* Next, run gcc on the generated assembly and the runtime */
  assembly := withext(test, ".s")
  defer os.Remove(assembly)
  executable := withext(test, "-" + filepath.Ext(test)[1:])
  cmd = exec.Command("gcc", "-m64", "-o", executable, assembly, Runtime)
  cmd.Stdout = &stdout
  cmd.Stderr = &stderr
  cmd.Stdin = nil
  if run(cmd, GccTimeout) != nil {
    fail("gcc timed out")
    return
  } else if !cmd.ProcessState.Success() {
    fail("gcc did not succeed")
    return
  }
  defer os.Remove(executable)

  /* Next, run the test itself */
  stdin, _ := os.Open(test + ".in") // if it doesn't exist, stdin == nil
  cmd = exec.Command(executable)
  cmd.Stdout = &stdout
  cmd.Stderr = &stderr
  cmd.Stdin = stdin
  if run(cmd, TestTimeout) != nil {
    fail("test timed out")
    return
  } else if stdin != nil {
    stdin.Close()
  }

  /* Finally, grade the results of the test */
  status := cmd.ProcessState.Sys().(syscall.WaitStatus)
  if directive.Kind == Exception {
    if cmd.ProcessState.Success() || !status.Signaled() {
      fail("executable ran successfully")
    } else if int(status.Signal()) != directive.Code {
      fail(fmt.Sprintf("expected signal %d, got %d", directive.Code,
                       status.Signal()))
    } else {
      pass()
    }
    return
  }
  if !cmd.ProcessState.Success() {
    if status.Signaled() {
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
  } else if int(ret) != directive.Code {
    stdout.Reset()
    fail(fmt.Sprintf("expected %d, got %d", directive.Code, int(ret)))
    return
  }

  /* Next check the output is what we're expecting */
  actual := stderr.String()
  expected, err := os.Open(test + ".out")
  if err != nil {
    pass()
    return // no expected output file
  }
  defer expected.Close()
  bytes, err := ioutil.ReadAll(expected)
  check(err)
  if string(bytes) != actual {
    fail("output is not as expected")
    return
  }
  pass()
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

func fail(err string) {
  println("error: ", err)
  os.Exit(1)
}

func failTest(test string, message string) {
  log <- "fail: " + test + " - " + message
}

func withext(file, ext string) string {
  return file[:len(file)-len(filepath.Ext(file))] + ext
}

func (d *Directive) parse(file string) bool {
  f, err := os.Open(file)
  defer f.Close()
  check(err)
  in := bufio.NewReader(f)
  line, err := in.ReadString('\n')
  check(err)
  matches := TestPattern.FindStringSubmatch(line)
  if matches == nil {
    failTest(file, "no test directive found or invalid test directive")
    return false
  }
  matches = matches[1:]
  switch matches[0] {
    case "error":
      d.Kind = Error
      return true /* error never has return code */
    case "exception":
      d.Kind = Exception
    case "return":
      d.Kind = Return
      if len(matches) == 1 || matches[1] == "" {
        failTest(file, "return directive requires a return value")
        return false
      }
  }
  d.Code = -1
  if len(matches) > 1 && matches[1] != "" {
    c, err := strconv.ParseInt(matches[1], 10, 32)
    if err != nil {
      failTest(file, fmt.Sprintf("invalid code specified: '%s'", matches[1]))
      return false
    }
    d.Code = int(c)
  }

  line, err = in.ReadString('\n')
  check(err)
  if line == "//safe" {
    d.Safe = true
  }

  return true
}

func tab(s string) string {
  return "    " + strings.Replace(s, "\n", "\n    ", -1)
}
