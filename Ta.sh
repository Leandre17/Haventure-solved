#! /bin/bash

STUDENT_OUTPUT="./student_output"
TEST_NUMBER=1

SUBJECTPATH=/var/jenkins_home/workspace/solution/
STUDENTPATH="."
INPUT=$(ls $SUBJECTPATH/Ex0$2/ | grep "input" | cut -c 6-)

if [ $(ls $STUDENTPATH/Ex0$2/ex0$2 | wc -l) -eq 0 ]; then 
    echo -e "\nDelivery error :(\n"
    echo "ex0$2 Délivery error :|" >> $3
    exit 1
fi


while IFS='\n' read -ra ADDR; do
    INPUTFILE=$SUBJECTPATH/Ex0$2/input$ADDR
    # BINARY_NAME=$SUBJECTPATH/Ex0$2/s.py
    BINARY_STUDENT=$STUDENTPATH/Ex0$2/ex0$2
    MY_OUTPUT=$SUBJECTPATH/Ex0$2/output$ADDR
    xargs -a $INPUTFILE $BINARY_STUDENT > $STUDENT_OUTPUT
    # xargs -a $INPUTFILE $BINARY_NAME > $MY_OUTPUT
    if [ $(diff $STUDENT_OUTPUT $MY_OUTPUT | wc -l) -ne 0 ]; then 
        echo -e "\nIn ex0$2:\t TEST $TEST_NUMBER FAILLED:" >> $3
        diff $STUDENT_OUTPUT $MY_OUTPUT >> $3
        echo "ex0$2 Fail at test number $TEST_NUMBER"
        exit 84;
    fi;
    TEST_NUMBER=$(($TEST_NUMBER + 1))
done <<< "$INPUT"

echo "ex0$2 SUCESS" >> $3
