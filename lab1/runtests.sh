#!/bin/zsh
# Usage ./runtests.sh
#
# Runs all tests in the tests/ directory of the compiler after rebuilding the
# compiler.
set -e

(cd compiler && make) &> /dev/null || (echo "make failed"; exit 1)

l1c="compiler/bin/l1c"

passed_tests=0
total_tests=0

function summary() {
  echo
  echo
  local bold='\e[1;1m'
  echo "  Summary: $bold$passed_tests/$total_tests passed"
  echo
  tput sgr0
}

trap 'summary; exit 1' SIGINT SIGTERM

# Prints a message of passing, first argument is failure message
function pass() {
  local green='\e[1;32m'
  echo -e "${green}passed"
  local binary=${test/%.l1/}
  [ -f $binary ] && rm $binary
  tput sgr0
  passed_tests=$(($passed_tests + 1))
  total_tests=$(($total_tests + 1))
}

# Prints a message of failure, first argument is failure message
function fail() {
  local red='\e[0;31m'
  echo -e "${red}$1"
  tput sgr0
  total_tests=$(($total_tests + 1))
}

# Compile source with gcc, first argument is l1 source test
function gcc_compile() {
  local test=$1
  local assem=${test/%l1/s}
  local out=${test/%.l1/}
  local log=${test/%l1/gcc.log}
  set +e
  gcc -m64 -Icompiler/runtime -o $out $assem compiler/runtime/l1rt.c &> $log
  ret=$?
  set -e

  if [ $ret -ne 0 ]; then
    fail "gcc compilation failed"
  fi
}

if [ "$1" = "" ]; then
  files=$(find tests -name '*.l1')
else
  files=$(find "$@" -name '*.l1')
fi

for test in $(echo $files); do
  echo -n $test ' '
  line=`head -n 1 $test`
  type=`echo $line | sed -E 's/\/\/test ([a-z]+).*/\\1/'`
  log=${test/%l1/l1c.log}

  set +e
  $l1c $test &> $log
  ret=$?
  set -e

  case $type in
    exception)
      if [ $ret -eq 0 ]; then
        gcc_compile $test
        if [ $ret -eq 0 ]; then
          program=${test/%.l1/}
          set +e
          output=$($program)
          ret=$?
          set -e
          if [ "$output" = "" ]; then
             [ $ret -eq 136 ] && pass || fail "Got 136, expected $ret"
          else
            fail "Output was produced: $output"
          fi
        fi
      else
        fail "$l1c failed"
      fi
      ;;
    return)
      if [ $ret -eq 0 ]; then
        gcc_compile $test
        if [ $ret -eq 0 ]; then
          expected=`echo $line | perl -ne 's/.*?(-?\d+).*/\\1/ && print'`
          program=${test/%.l1/}
          set +e
          output=$($program)
          set -e
          [ $output -eq $expected ] && pass \
                                    || fail "Got $output, expected $expected"
        fi
      else
        fail "$l1c failed"
      fi
      ;;
    error)
      [ $ret -eq 1 ] && pass || fail "$l1c succeeded"
      ;;
  esac

done

summary
