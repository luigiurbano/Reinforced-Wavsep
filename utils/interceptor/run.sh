#!/bin/bash  

acquire() {
    truncate -s 0 tcpdump.txt
    tcpdump  -i any port 8080 -w tcpdump.txt &
} 
 
usage() {
    echo "interceptor <init_script> <end_script>"
    exit 1
}



if (( $# < 2 )) 
then 
    usage
fi
acquire 

STARTED=0
STOP=0
init_script=$1
end_script=$2

while [[ $STOP -ne 1 ]]
do 
    CURR=`cat /app/tcpdump.txt | wc -l`
    if [[ $CURR != 0 && $STARTED == 0 ]] 
    then 
        eval $init_script
        STARTED=1
    fi
    if [[ $PREV == $CURR && $PREV != 0 ]]
    then 
        echo "Completed"
        eval $end_script
        STOP=1
    fi
    sleep 3
    PREV=$CURR

done