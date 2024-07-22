
#!/bin/bash
BASEDIR=${PWD}
XSS_FOLDER=/webapp/active/Reflected-XSS
SQL_FOLDER=/webapp/active/SQL-Injection/
LFI_FOLDER=/webapp/active/LFI/

function count_test_cases() {
    COUNT=`find . -name \*.jsp | grep -v index.jsp | wc -l`
    echo "Number of cases in ${PWD}: $COUNT"
}

function print_test_cases() {
    find . -name \*.jsp | grep -v index.jsp | sed "s|\./|${1}|g" | sed "s|/webapp/|/wavsep/|g"
}

function count_xss() {
    cd src/main${XSS_FOLDER}
    count_test_cases
    cd ${BASEDIR}
}
function print_xss() {
    cd src/main${XSS_FOLDER}
    print_test_cases ${XSS_FOLDER}
    cd ${BASEDIR}
}



function print_sql() {
    cd src/main${SQL_FOLDER}
    print_test_cases ${SQL_FOLDER}
    cd ${BASEDIR}
}

function print_lfi() {
    cd src/main${LFI_FOLDER}
    print_test_cases ${LFI_FOLDER}
    cd ${BASEDIR}
}