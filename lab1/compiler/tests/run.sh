sml <<-EOF
CM.make "tests/sources.cm";
print "Running tests for LivenessTest\n";
TestUtils.runtests LivenessTest.tests;
print "Running tests for AllocationTests\n";
TestUtils.runtests AllocationTests.tests;
EOF
