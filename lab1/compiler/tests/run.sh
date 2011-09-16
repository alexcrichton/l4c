sml <<-EOF
CM.make "tests/sources.cm";
print "Running tests for LivenessTest\n";
TestUtils.runtests LivenessTest.tests;
print "Running tests for AllocationTest\n";
TestUtils.runtests AllocationTest.tests;
print "Running tests for AssemTest\n";
TestUtils.runtests AssemTest.tests;
EOF
