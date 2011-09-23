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

############################################################

###
# Declarations and Initialization
#
our $Opt_Autograding    = 0;    # -A, autograding, hidden flag for autograder
our $Opt_Debug          = 0;    # -d <debug> (default 0)
our $Opt_Help           = 0;    # -h, help
our $Opt_Make           = 1;    # -m, build compiler (on by default)
our @Opt_Suite          = ();   # -s <dir>, 
our $Opt_Tests          = 0;    # -t, validate test files with ref.comp.
our @Testfiles;                 # files... (default ../tests0)

my $num_tried0      = 0;    # number of tests0 tried
my $num_succeeded0  = 0;    # number of tests0 succeeded
my $score0          = 0;    # score for suite 0
my $num_tried1      = 0;    # number of tests1 tried
my $num_succeeded1  = 0;    # number of tests1 succeeded
my $score1          = 0;    # score for suite 1
my $result          = "";   # result string for Autolab server

my $success = GetOptions (
    'autograde'     => \$Opt_Autograding,
    'debug=i'       => \$Opt_Debug,
    'help'          => \$Opt_Help,
    'make!'         => \$Opt_Make,
    'suite=s@'      => \@Opt_Suite,
    'tests'         => \$Opt_Tests,
);
$success or pod2usage();

pod2usage(1) if $Opt_Help;

@Testfiles = @ARGV;
$DEBUG = $Opt_Debug;

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
        @Testfiles = glob "$TEST_SUITES_PATH/tests/*.$LEXT";
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
        my @files = glob "$TEST_SUITES_PATH/$suite/*.$LEXT";
        ($tried, $succeeded, @failedhere) = run_suite(@files);
        push @failed, @failedhere;
        $results{$suite} = [$tried, $succeeded];
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
    my ($command, $compiler_result, $assembler_result);
    if (-e "a.out") { unlink "a.out" or die "could not remove a.out\n"; }
    if (-e "a.result") { unlink "a.result" or die "could not remove a.result\n"; }

    printad(0, "-- Testing file $file --\n");

    ($directive, $expected) = read_testdirective($file);
    ($valid, $error) = test_directive_verify($directive, $expected);
    if (!$valid) {
        return fail($error);
    }

    $asm_file = asm_suffix($file);
    if (-e $asm_file) {move($asm_file, $asm_file.".old")
            or die "could not rename $asm_file from previous compilation\n";}

    $command = "$COMPILER_EXEC $COMPILER_ARGS $file";
    $compiler_result = system_with_timeout($COMPILER_TIMEOUT, "$command");

    if ($directive eq "error") {
        if ($compiler_result == 0) {
            return fail("Compilation unexpectedly succeeded on $file.\n");
        } else {
            return pass("Compilation failed on $file as expected.\n");
        }
    }

    if ($compiler_result != 0) {
        return fail("Compilation unexpectedly failed on $file.\n");
    }

    $command = "$GCC $asm_file $RUNTIME";
    $assembler_result = system_with_timeout($GCC_TIMEOUT, $command);
    if ($assembler_result != 0) {
        return fail("Assembly failed on $file.\n");
    }

    $result = system_with_timeout($RUN_TIMEOUT, "./a.out 2>&1 > a.result");
    $result = ($result >> 8) & 0x7F; # because shell return code
    
    if ($directive eq "exception") {
        if ($expected ne "") {
            $expected = $expected+0;  # convert to integer, for sanity's sake
            if ($result == $expected) {
                return pass("Execution of binary raised appropriate exception $result.\n");
            }
            else {
                return fail("Execution of binary raised inappropriate exception $result; expected $expected.\n");
            }
        }
        elsif ($result != 0) {
            return pass("Execution of binary raised exception $result.\n");
        } else {
            return fail("Execution of binary unexpectedly succeeded.\n");
        }
    } elsif ($directive eq "return") {
        if ($result != 0) {
            return fail("Execution of binary unexpectedly failed with exception $result.\n");
        }

        # if a.result does not exist, $all_of_file = ''
        my $all_of_file = read_file("a.result");
        chomp $all_of_file;
        if ($all_of_file eq $expected) {
            return pass("Correct result\n");
        } else {
            return fail("Result '$all_of_file' differs from expected answer '$expected'.\n");
        }
    }

    printf("I can't be here (test $file)! Inconcievable!\n");
    printf("Send mail to course staff, please.\n");
    return fail("");
}

###
# $p1ass = validate (<f>.$LEXT)
# compile and test given file
#
sub validate {
    my $file = shift;
    my ($directive, $expected, $result, $valid, $error);
    my ($command, $compiler_result, $res_known, $res_quarantine, $res_crash);

    if (-e "a.out") { unlink "a.out" or die "could not remove a.out\n"; }
    if (-e "a.result") { unlink "a.result" or die "could not remove a.result\n"; }

    printad(0, "-- Testing file $file --\n");

    ($directive, $expected) = read_testdirective($file);
    ($valid, $error) = test_directive_verify($directive, $expected);
    if (!$valid) {
        return fail($error);
    }

    $command = "$REF_COMPILER $REF_COMPILER_ARGS $file";
    $compiler_result = system_with_timeout($COMPILER_TIMEOUT, "$command");
    $res_known = 256;
    $res_quarantine = 512;
    $res_crash = 254;
    #print $compiler_result;

    if ($compiler_result == $res_crash) {
        return fail("Compilation crashed: reference compiler bug!\n"
                   ."Send mail to the course staff, please.\n");
    }

    if ($directive eq "error") {
        if ($compiler_result == 0) {
            return fail("Compilation unexpectedly succeeded on $file.\n");
        }
        if ($compiler_result == $res_known) {
            return pass("Compilation failed on $file as expected.\n");
        }
        if ($compiler_result == $res_quarantine) {
            return fail("Future language features used in $file.\n");
        }
        return fail("Mysterious error $compiler_result.\n"
                   ."Send mail to course staff, please.\n");
    }

    if ($compiler_result != 0) {
        ## build error, but we didn't have an error directive.
        ## bail now.
        if ($compiler_result == $res_known) {
            return fail("Compilation unexpectedly failed on $file.\n");
        }
        if ($compiler_result == $res_quarantine) {
            return fail("Future language features used in $file.\n");
        }
        return fail("Mysterious error $compiler_result.\n"
                   ."Send mail to course staff, please.\n");
    }

    $result = system_with_timeout($RUN_TIMEOUT, "./a.out 2>&1 > a.result");
    $result = ($result >> 8) & 0x7F; # shift because shell return code

    if ($directive eq "exception") {
        if ($result == 0) {
            return fail("Execution of binary unexpectedly succeeded.\n");
        }
        if ($expected eq "") {
            return pass("Execution of binary raised exception $result.\n");
        }
        $expected = $expected+0;  # convert to integer, for sanity's sake
        if ($result == $expected) {
            return pass("Execution of binary raised appropriate exception $result.\n");
        }
        return fail("Execution of binary raised inappropriate exception $result; expected $expected.\n");
    }
    elsif ($directive eq "return") {
        if ($result != 0) {
            return fail("Execution of binary unexpectedly failed with exception $result.\n");
        }
        # if a.result does not exist, $all_of_file = ''
        my $all_of_file = read_file("a.result");
        chomp $all_of_file;
        if ($all_of_file eq $expected) {
            return pass("Correct result\n");
        }
        return fail("Result '$all_of_file' differs from expected answer '$expected'.\n");
    }

    printf("I can't be here (test $file)! Inconcievable!\n");
    printf("Send mail to course staff, please.\n");
    return fail("");
}

###
# make_compiler
# runs make and aborts if unsuccessful
#
sub make_compiler {
    my $result;
    if (system_with_timeout($MAKE_TIMEOUT, "make $COMPILER") != 0) {
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
    unless ($Opt_Autograding) {
        printd($d, $msg);
    }
}

###
# Convenience function for passing results
#
sub pass {
    my $msg = shift;
    printad(1, $msg);
    printad(0, "-- PASS --\n");
    return 1;
}

###
# Convenience function for failing results
#
sub fail {
    my $msg = shift;
    printad(0, $msg);
    printad(0, "-- FAIL --\n");
    return 0;
}

###
# asm_suffix(<file>) = <file>.s
#
sub asm_suffix {
    my $file = shift;
    my @fields = split(/[.]/, $file);
    if (scalar @fields == 1) {
        return $fields[0].".s"; # append ".s" if no extension
    } else {
        @fields[@fields-1]="s"; # replace extension with "s" otherwise
        return join('.', @fields);
    }
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
    ($test, $directive, $value) = split(/\s+/, $line, 3);
    if ($test eq "//test") {
        chomp $value;
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

Emit grading output for Autolab. Also disables most test-by-test information,
since Autolab will keel over and die if the grader produces too much output

=item -d <level>, --debug <level>

Set debug level to <level> (default 0).

=item -h, --help

Show this help message.

=item --nomake

Do not build the compiler before beginning grading.

=item -s <suite>, --suite <suite>

Run compiler with test suite <suite>. This option can be passed more than once
to run multiple test suites. This option will be ignored when validating tests.

=item -t, --tests

Validate test files in "tests" suite using reference compiler.

=back

=cut
