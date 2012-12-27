#!/bin/sh

set -e
make

function runtests() {
  echo -----------------------------------------
  echo - $1 tests
  echo -----------------------------------------

  ./driver.pl -qq -g -j4 -p "-O4 --arch $1" -w $1-failures$2 --nomake $3
}

sed -i '' s/m32/m64/ DriverConfig.pm
runtests x64
runtests x64 -safe '../tests*/*.s4 -p --safe'
sed -i '' s/m64/m32/ DriverConfig.pm
runtests x86
runtests x86 -safe '../tests*/*.s4 -p --safe'
