#!/bin/bash
BASEDIR=${PWD}

function count_test_cases() {
    COUNT=`find . -name \*.jsp | grep -v index.jsp | wc -l`
    echo "Number of cases in ${PWD}: $COUNT"
}

function print_test_cases() {
    find . -name \*.jsp | grep -v index.jsp 
}

function count_xss() {
    cd src/main/webapp/active/Reflected-XSS
    count_test_cases
    cd ${BASEDIR}
}
function print_xss() {
    cd src/main/webapp/active/Reflected-XSS
    print_test_cases
    cd ${BASEDIR}
}
