cat <<-EOF | sml
CM.make "tests/sources.cm";
print "Running tests for LivenessTest\n";
TestUtils.runtests LivenessTest.tests;
EOF
