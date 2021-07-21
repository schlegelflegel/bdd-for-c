#!/bin/bash

# check the number of argument
if test "$#" -le 0
then
    echo "no tests specified."
    exit 0
fi

# store the number of tests
num_total=0
num_passed=0

for test in "$@"
do
    $test && ((num_passed++))
    ((num_total++))
done

# calculate the number of failed tests and print the result
((num_failed = num_total - num_passed))
if test "$num_failed" -eq 0
then
    echo -e "summary: \e[32;1m$num_passed passed\e[0m, $num_total total"
elif test "$num_passed" -eq 0
then
    echo -e "summary: \e[31;1m$num_failed failed\e[0m, $num_total total"
else
    echo -e "summary: \e[32;1m$num_passed passed\e[0m, \e[31;1m$num_failed failed\e[0m, $num_total total"
fi
