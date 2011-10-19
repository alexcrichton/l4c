#!/usr/bin/perl
##############################################################
## driver.pl - 15-411 Driver                                ##
##                                                          ##
## Driver for CMU, 15-411 Compiler Design, Fall 2007-2011   ##
## Functionality:  building compiler, compiling tests,      ##
##                 validating tests with reference compiler ##
##                 testing compiler                         ##
##                                                          ##
##############################################################

use strict;
use warnings;

use lib ".";
use Driverlib;
use DriverConfig;

use File::Copy;
use Getopt::Long;
use Pod::Usage;

use Term::ANSIColor;

############################################################

###
# Declarations and Initialization
#
our $Opt_Autograding    = 0;    # -A, autograding, hidden flag for autograder
our $Opt_Color          = "auto"; # -c, color
our $Opt_FailFast       = 0;    # -f, --fail-fast
our $Opt_Help           = 0;    # -h, help
our $Opt_Make           = 1;    # -m, build compiler (on by default)
our $Opt_Pass           = "";   # -p <args>, arguments to compiler
our $Opt_Quiet          = 0;    # -q, quiet
our @Opt_Suite          = ();   # -s <dir>, 
our $Opt_Tests          = 0;    # -t, validate test files with ref.comp.
our $Opt_Verbose        = 0;    # -v (stacks)
our @Testfiles;                 # files... (default ../tests0)

my $num_tried0      = 0;    # number of tests0 tried
my $num_succeeded0  = 0;    # number of tests0 succeeded
my $score0          = 0;    # score for suite 0
my $num_tried1      = 0;    # number of tests1 tried
my $num_succeeded1  = 0;    # number of tests1 succeeded
my $score1          = 0;    # score for suite 1
my $result          = "";   # result string for Autolab server

Getopt::Long::Configure ("bundling");
my $success = GetOptions (
    'A|autograde'   => \$Opt_Autograding,
    'c|color=s'     => \$Opt_Color,
    'f|fail-fast!'  => \$Opt_FailFast,
    'h|help'        => \$Opt_Help,
    'make!'         => \$Opt_Make,
    'p|pass=s'      => \$Opt_Pass,
    'q|quiet+'      => \$Opt_Quiet,
    's|suite=s@'    => \@Opt_Suite,
    't|tests'       => \$Opt_Tests,
    'v|verbose+'    => \$Opt_Verbose,
);
$success or pod2usage();

pod2usage(1) if $Opt_Help;

@Testfiles = @ARGV;
$DEBUG = $Opt_Verbose;
$QUIET = $Opt_Quiet;

if ($Opt_Color eq "auto") {
	$Opt_Color = -t STDOUT;
}
elsif ($Opt_Color eq "on") {
	$Opt_Color = 1;
}
else {
	$Opt_Color = 0;
}

if (@Opt_Suite && @ARGV) {
    die "Not allowed to specify a suite *and* individual tests!";
}

if ($Opt_Autograding && (@Opt_Suite || @ARGV)) {
    die "Autograding only runs on default suite of tests";
}

foreach my $suite (@Opt_Suite) {
    -d "../$suite" or die "Bad suite: ../$suite not a folder";
}

main();

############################################################

###
# Main program
#
sub main {
    autoflush STDOUT 1;

    if ($Opt_Tests) {
        grade_tests();
    }
    else {
        grade_compiler();
    }

    exit(0);
}

###
# Do tests grading
#
sub grade_tests {
    my $tried = 0;          # number of tests tried
    my @failed = ();
    my $succeeded = 0;      # number of tests succeeded
    my $score = 0;              # total score

    my $grading = 0;

    printf("-- Validating test files --\n");

    if (!@Testfiles) {
        $grading = 1;
        @Testfiles = glob "$TEST_SUITES_PATH/tests/*.l$LAB";
    }

    foreach my $test (@Testfiles) {
        $tried++;
        if (validate($test)) {
            $succeeded++;
        } else {
            push @failed, $test;
        }
    }

    printf("\n-- Summary --\n");

    if (@failed) {
        printf("Tests failed:\n");
        print map {"   $_\n"} @failed;
    }

    if (!$grading) {
        printf("Validated $succeeded / $tried specified tests\n");
        return;
    } else {
        my ($grade, $max) = tests_grade($tried, $succeeded);
        printf("Validated $succeeded / $tried tests for a score of $grade / $max points\n");
        my $result = join(':', $tried, $succeeded, $grade);
        report_result($result, $Opt_Autograding);
    }
}

###
# grade student compiler
#
sub grade_compiler {
    my $tried = 0;
    my @failed = ();
    my $succeeded = 0;
    my $score = 0;

    my @failedhere;

    if ($Opt_Make) {
        printf("-- Building compiler --\n");
        make_compiler();      # aborts if unsuccessful
    }

    printf("-- Testing compiler --\n");

    # individual tests
    if (@Testfiles) {
        ($tried, $succeeded, @failed) = run_suite(@Testfiles);
        if ($Opt_FailFast && @failed) {
            printf("Not running remaining tests.\n");
            return;
        }
        printf("\n-- Summary --\n");
        if (@failed) {
            printf("Tests failed:\n");
            print map {"   $_\n"} @failed;
        }
        printf("Passed $succeeded / $tried specified tests\n");
        return;
    }

    # full test suites

    if (!@Opt_Suite) {
        @Opt_Suite = sort keys %$CMPL_GRADE;
    }

    my %results = ();
    foreach my $suite (@Opt_Suite) {
        printf("-- Running $suite --\n");
        my @files;
        foreach my $lext (@LEXTS) {
            push @files, glob "$TEST_SUITES_PATH/$suite/*.$lext";
        }
        ($tried, $succeeded, @failedhere) = run_suite(@files);
        push @failed, @failedhere;
        if (@failed && $Opt_FailFast) {
            last;
        }
        $results{$suite} = [$tried, $succeeded];
    }

    if ($Opt_FailFast && @failed) {
        printf("Not running remaining tests.\n");
        return;
    }

    printf("\n-- Summary --\n");

    if (@failed) {
        printf("Tests failed:\n");
        print map {"   $_\n"} @failed;
    }

    my $total = 0;
    my $maxtotal = 0;
    foreach my $suite (sort keys %results) {
        my ($tried, $succeeded) = @{$results{$suite}};
        if ($CMPL_GRADE->{$suite}) {
            my ($grade, $max) = &{$CMPL_GRADE->{$suite}}($tried, $succeeded);
            $total += $grade;
            $maxtotal += $max;
            printf("$suite: passed $succeeded / $tried tests for a score of $grade / $max points\n");
            $results{$suite} = [$tried, $succeeded, $grade];
        }
        else {
            printf("$suite: passed $succeeded / $tried tests on unknown suite\n");
        }
    }
    printf("Total points on tested suites: $total / $maxtotal\n");
    
    if ($results{tests0} && $results{tests1} && $results{tests2}) {
        my $result = join(':', @{$results{tests0}}, @{$results{tests1}},
                               @{$results{tests2}});
        report_result($result, $Opt_Autograding);
    }
}

###
# Grade one test suite
# ($tried, $succeeded) = run_suite(file1, file2, ...);
#
sub run_suite {
    my $tried = 0;
    my $succeeded =0;
    my @failed = ();
    foreach my $test (@_) {
        $tried++;
        if (test($test)) {
            $succeeded++;
        }
        else {
            push @failed, $test;
            if ($Opt_FailFast) {
                last;
            }
        }
    }
    return ($tried, $succeeded, @failed);
}


###
# $pass = test (<f>.$LEXT)
# test compiler on given file
#
sub test {
    my $file = shift;
    my ($directive, $expected, $valid, $error, $asm_file, $result, $line);
    my $command;
    my $ret;
    if (-e "a.out") { unlink "a.out" or die "could not remove a.out\n"; }
    if (-e "a.result") { unlink "a.result" or die "could not remove a.result\n"; }

    my ($read, $write);
    if ($Opt_Quiet == 0) {
        open($write, ">&STDOUT");
    }
    else {
        pipe($read, $write);
    }
    my $p = [$read, $write];

    printq(2, "-- Testing file $file --\n", $write);

    ($directive, $expected) = read_testdirective($file);
    ($valid, $error) = test_directive_verify($directive, $expected);
    if (!$valid) {
        return fail($error, $file, $p);
    }

    $asm_file = asm_suffix($file);
    if (-e $asm_file) {move($asm_file, $asm_file.".old")
            or die "could not rename $asm_file from previous compilation\n";}

    $command = "$COMPILER_EXEC $COMPILER_ARGS $file $Opt_Pass";
    $result = system_with_timeout($COMPILER_TIMEOUT, "$command",
                                  $write, $write);

    if ($result == 0) {
        $command = "$GCC $asm_file $RUNTIME";
        $result = system_with_timeout($GCC_TIMEOUT, $command,
                                      $write, $write);
    }

    # the 0 means "this is not the reference compiler"
    $ret = grade_compilation($file, $result, $directive, $expected, 0, $p);
    if (defined $ret) {
        return $ret;
    }

    $command = "./a.out";
    my $in_file = in_suffix($file);
    if (-f $in_file) {
        $in_file = "< $in_file";
    }
    else {
        $in_file = undef;
    }
    $result = system_with_timeout($RUN_TIMEOUT, $command, "> a.result", "> a.output", $in_file);
    
    return grade_execution($file, $result, $directive, $expected, $p);
}

###
# $p1ass = validate (<f>.$LEXT)
# compile and test given file
#
sub validate {
    my $file = shift;
    my ($directive, $expected, $result, $valid, $error);
    my ($command, $compiler_result, $res_known, $res_quarantine, $res_crash);
    my $ret;

    if (-e "a.out") { unlink "a.out" or die "could not remove a.out\n"; }
    if (-e "a.result") { unlink "a.result" or die "could not remove a.result\n"; }

    my ($read, $write);
    if ($Opt_Quiet == 0) {
        open($write, ">&STDOUT");
    }
    else {
        pipe($read, $write);
    }
    my $p = [$read, $write];

    printq(2, "-- Testing file $file --\n", $write);

    ($directive, $expected) = read_testdirective($file);
    ($valid, $error) = test_directive_verify($directive, $expected);
    if (!$valid) {
        return fail($error, $file, $p);
    }

    $command = "$REF_COMPILER $REF_COMPILER_ARGS $file";
    $result = system_with_timeout($COMPILER_TIMEOUT, "$command",
                                  $write, $write);

    $result = ($result >> 8) & 0x7F; # shift because shell return code

    # the 1 means "this is the reference compiler"
    $ret = grade_compilation($file, $result, $directive, $expected, 1, $p);
    if (defined $ret) {
        return $ret;
    }

    $command = "./a.out";
    my $in_file = in_suffix($file);
    if (-f $in_file) {
        $in_file = "< $in_file";
    }
    else {
        $in_file = undef;
    }
    $result = system_with_timeout($RUN_TIMEOUT, $command, "> a.result", "> a.output", $in_file);

    return grade_execution($file, $result, $directive, $expected, $p);
}

###
# $ret = grade_compilation($file, $result, $directive, $expected, $is_ref);
# if (defined $ret) {
#     return $ret;
# }
#
sub grade_compilation {
    my $file = shift;
    my $result = shift;
    my $directive = shift;
    my $expected = shift;
    my $is_ref_compiler = shift;
    my $p = shift;

    my $res_known = 1;
    my $res_quarantine = 2;
    my $res_crash = 3;

    if ($is_ref_compiler && $result == $res_crash) {
        return fail("Compilation crashed: reference compiler bug!\n"
                   ."Send mail to the course staff, please.\n", $file, $p);
    }

    if ($directive eq "error") {
        if ($result == 0) {
            return fail("Compilation unexpectedly succeeded on $file.\n",
                        $file, $p);
        }
        if (!$is_ref_compiler || $result == $res_known) {
            return pass("Compilation failed on $file as expected.\n",
                        $file, $p);
        }
        if ($result == $res_quarantine) {
            return fail("Future language features used in $file.\n", $file, $p);
        }
        return fail("Mysterious error $result.\n"
                   ."Send mail to course staff, please.\n", $file, $p);
    }

    if ($result != 0) {
        ## build error, but we didn't have an error directive.
        ## bail now.
        if (!$is_ref_compiler || $result == $res_known) {
            return fail("Compilation unexpectedly failed on $file.\n",
                        $file, $p);
        }
        if ($result == $res_quarantine) {
            return fail("Future language features used in $file.\n",
                        $file, $p);
        }
        return fail("Mysterious error $result.\n"
                   ."Send mail to course staff, please.\n", $file, $p);
    }

    return undef;
}

###
# return grade_execution($file, $result, $directive, $expected);
#
sub grade_execution {
    my $file = shift;
    my $result = shift;
    my $directive = shift;
    my $expected = shift;
    my $p = shift;

    if ($result != 0) {
        $result = $result - 128; # killed by signal
    }

    if ($directive eq "exception") {
        if ($result == 0) {
            return fail("Execution of binary unexpectedly succeeded.\n",
                        $file, $p);
        }
        if (!defined $expected) {
            return pass("Execution of binary raised exception $result.\n",
                        $file, $p);
        }
        $expected = $expected+0;  # convert to integer, for sanity's sake
        if ($result == $expected) {
            return pass("Execution of binary raised appropriate exception $result.\n",
                        $file, $p);
        }
        return fail("Execution of binary raised inappropriate exception $result; expected $expected.\n",
                    $file, $p);
    }
    elsif ($directive eq "return") {
        if ($result != 0) {
            return fail("Execution of binary unexpectedly failed with exception $result.\n",
                        $file, $p);
        }
        # if a.result does not exist, $all_of_file = ''
        my $return = read_file("a.result");
        chomp $return;
        if ($return eq $expected) {
            my $out_file = out_suffix($file);
            if (! -e $out_file) {
                return pass("Correct result\n", $file, $p);
            }
            my $output = read_file("a.output");
            my $expected_output = read_file(out_suffix($file));
            if ($output eq $expected_output) {
                return pass("Correct result\n", $file, $p);
            }
            else {
                return fail("Correct return value, but output differs from expected output\n",
                            $file, $p);
            }
        }
        return fail("Result '$return' differs from expected answer '$expected'.\n",
                    $file, $p);
    }

    print "I can't be here (test $file)! Inconcievable!\n";
    print "Send mail to course staff, please.\n";
    return fail("", $file, $p);
}

###
# make_compiler
# runs make and aborts if unsuccessful
#
sub make_compiler {
    my $result;
    my $write;

    if ($Opt_Quiet < 4) {
        $write = undef;
    }
    else {
        $write = ">/dev/null";
    }

    $result = system_with_timeout($MAKE_TIMEOUT, "make $COMPILER",
                                  $write, $write);
    if ($result != 0) {
        die "make did not succeed\n";
    }
    if (!-e "$COMPILER_EXEC" || !-x "$COMPILER_EXEC") {
        die "compiler does not exist or is not executable\n";
    }
    return 0;
}

###
# Printd only if not autograding
# (Autolab gets overwhelmed by large amounts of output)
#
sub printad {
    my $d = shift;
    my $msg = shift;
    my $color = shift;

    my $do_color = defined $color && $Opt_Color;

    unless ($Opt_Autograding) {
        printd($d, color($color)) if $do_color;
        printd($d, $msg);
        printd($d, color("reset")) if $do_color;
    }
}

###
# Convenience function for passing results
#
sub pass {
    my $msg = shift;
    my $file = shift;
    my $p = shift;

    my ($r, $w) = @$p;
    close($w);
    if (defined $r) {
        close($r);
    }

    printq(0, $msg);

    printq(1, color("green"));
    printq(1, "-- PASS $file --\n");
    printq(1, color("reset"));

    return 1;
}

###
# Convenience function for failing results
#
sub fail {
    my $msg = shift;
    my $file = shift;
    my $p = shift;

    my ($r, $w) = @$p;
    close($w);
    if (defined $r) {
        while (my $line = <$r>) {
            print $line;
        }
        close($r);
    }

    printq(2, $msg);

    printq(2, color("red"));
    printq(2, "-- FAIL $file --\n");
    printq(2, color("reset"));
    return 0;
}

sub suffix {
    my $file = shift;
    my $suffix = shift;
    my @fields = split(/[.]/, $file);
    if (scalar @fields == 1) {
        return $fields[0].".".$suffix; # append ".s" if no extension
    } else {
        @fields[@fields-1]=$suffix; # replace extension with "s" otherwise
        return join('.', @fields);
    }
}

###
# asm_suffix(<file>) = <file>.s
#
sub asm_suffix {
    my $file = shift;
    suffix($file, "s");
}

sub in_suffix {
    my $file = shift;
	return "$file.in"
}

sub out_suffix {
    my $file = shift;
	return "$file.out"
}

###
# ($directive, $value) = read_testdirective($file)
# parses the first line of a test file
# #test <directive> <value>
# where value is optional
# $directive may be undefined (if line is not well-formed),
# as may be $value
#
sub read_testdirective {
    my $file = shift;
    my $line;
    my ($test, $directive, $value);
    open(MYFILE, "<$file") or die "can't open test file: $file\n";
    $line = <MYFILE>;
    $line =~ s/\s*$//;
    ($test, $directive, $value) = split(/\s+/, $line, 3);
    if ($test eq "//test") {
        if (defined $value) {
            chomp $value;
        }
        return ($directive, $value);
    } else {
        return (undef, undef);
    }
}

###
# Check validity of the test directive
# returns (1, undef) if valid, (0, errormessage) otherwise 
#
sub test_directive_verify {
    my $directive = shift;
    my $expected = shift;

    unless (defined $directive) {
        return (0, "Bad test: test directive not found\n");
    }
    unless ($directive eq "error" || $directive eq "exception"
            || $directive eq "return") {
        return (0, "Bad test: unrecognized test directive $directive\n");
    }
    if ($directive eq "return" && !defined $expected) {
        return (0, "Bad test: return directive with no value\n");
    }

    return (1, undef);
}

__END__

############################################################

=pod

=head1 NAME

driver.pl - 15-411 Autolab/testing driver

=head1 SYNOPSIS

driver.pl [options] [files]

  $ ./driver.pl
  $ ./driver.pl --suite tests0 --suite tests1
  $ ./driver.pl ../test0/return01.l1
  $ ./driver.pl --tests

=head1 DESCRIPTION

This directory contains the driver files for testing your compiler. These are
identical to the files the Autolab server uses identical files to grade your
code upon hand-in.

If you do not specify any tests, the default behaviour is:

=over 8

=item -s tests0 -s tests1 -s tests2

Use the full grading suite when testing the compiler

=item ../tests/*.<extension>

Run on all relevant tests when doing validation

=back

=head1 OPTIONS

=over 8

=item -A, --autograde

Emit grading output for Autolab. Implies -qq, since Autolab will keel over and
die if the grader produces too much output.

=item -c [on|off|auto], --color [on|off|auto]

Make pass/fail messages colorful.

=item -f, --fail-fast

When one test fails, cease running tests.

=item -h, --help

Show this help message.

=item --nomake

Do not build the compiler before beginning grading.

=item -p <args>, --pass <args>

Pass arguments along to the compiler.

=item -q, --quiet

Quiet mode. Pass multiple times for quieter grading:

=over 4

=item -q emits only one line of output for passing tests

=item -qq silences passing tests

=item -qqq silences all tests

=item -qqqq silences building the compiler

=back

=item -s <suite>, --suite <suite>

Run compiler with test suite <suite>. This option can be passed more than once
to run multiple test suites. This option will be ignored when validating tests.

=item -t, --tests

Validate test files in "tests" suite using reference compiler.

=item -v, --verbose

Enable driver debugging output. Pass more times for more output.

=back

=cut
