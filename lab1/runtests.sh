#!/bin/zsh
# Usage ./runtests.sh
#
# Runs all tests in the tests/ directory of the compiler after rebuilding the
# compiler.

set -e

cd compiler
make &> /dev/null

l1c=bin/l1c

# Prints a message of passing, first argument is failure message
function pass() {
  local green='\e[1;32m'
  echo -e "${green}passed"
  tput sgr0
}

# Prints a message of failure, first argument is failure message
function fail() {
  local red='\e[0;31m'
  echo -e "${red}$1"
  tput sgr0
}

# Compile source with gcc, first argument is l1 source test
function gcc_compile() {
  local test=$1
  local assem=${test/%l1/s}
  local out=${test/%.l1/}
  local log=${test/%l1/gcc.log}
  set +e
  gcc -Iruntime -o $out $assem runtime/l1rt.c &> $log
  ret=$?
  set -e

  if [ $ret -ne 0 ]; then
    fail "gcc compilation failed"
  fi
}

for test in $(find ../tests -name '*.l1'); do
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
          echo maybe
        fi
      else
        fail "$l1c failed"
      fi
      ;;
    return)
      if [ $ret -eq 0 ]; then
        gcc_compile $test
        if [ $ret -eq 0 ]; then
          echo maybe
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
