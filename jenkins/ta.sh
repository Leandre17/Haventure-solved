#!/usr/bin/env bash

EXEC=$1
STUDENT_OUTPUT="./student_output"
MY_OUTPUT="./my_output"
TEST_NUMBER=1
INPUT=$(ls sujet/Ex0$2/ | grep "input" | cut -c 6-)
STATUS="/var/jenkins_home/workspace/status/$4"
if [ $(ls ./$3/Ex0$2/$1 | wc -l) -eq 0 ]; then 
    echo -e "\nDelivery error :(\n"
    echo "ex0$2 Délivery error :|" >> $STATUS
    exit 1
fi

chmod +x ./$3/Ex0$2/$1
chmod +x ./solution/Ex0$2/$1

while IFS='\n' read -ra ADDR; do
    cat sujet/Ex0$2/input$ADDR | ./$3/Ex0$2/$1 > $STUDENT_OUTPUT
    cat sujet/Ex0$2/input$ADDR | ./solution/Ex0$2/$1 > $MY_OUTPUT
    if [ $(diff $STUDENT_OUTPUT $MY_OUTPUT | wc -l) -ne 0 ]; then 
        echo -e "\nIn ex0$2:\t TEST $TEST_NUMBER FAILLED:"
        diff $STUDENT_OUTPUT $MY_OUTPUT
        echo "ex0$2 Fail at test number $TEST_NUMBER" >> $STATUS
        exit 84;
    fi;
    TEST_NUMBER=$((TEST_NUMBER + 1))
done <<< "$INPUT"

echo "ex0$2 SUCCEED" >> $STATUS
