#!/bin/bash

##########Variables###########
to=$1
subject=$2
body=$3
file=/tmp/temp.txt
repeat=1                   #Number of message sent for High severity 
urgent_repeat=3            #Number of message sent for Disaster severity 
duration=60                #Duration of each message sent


##########Function############
Status_Problem_High(){
       curl -s –max-time 10 -d "chat_id=-342387488&disable_web_page_preview=1&text=`echo -e '\u26A0\uFE0F'`$Topic
$item" https://api.telegram.org/bot731592033:AAGyaKK_bxK-mDtJgijwWE5Ldz16WN0pSKE/sendMessage
}
Status_Problem_Disaster(){
       curl -s –max-time 10 -d "chat_id=-342387488&disable_web_page_preview=1&text=`echo -e '\U0001F198'`$Topic
$item" https://api.telegram.org/bot731592033:AAGyaKK_bxK-mDtJgijwWE5Ldz16WN0pSKE/sendMessage
}
Status_OK(){
       curl -s –max-time 10 -d "chat_id=-342387488&disable_web_page_preview=1&text=`echo -e '\u2705'`$Topic
$item" https://api.telegram.org/bot731592033:AAGyaKK_bxK-mDtJgijwWE5Ldz16WN0pSKE/sendMessage
}



############Main##############
echo -e "$subject \n$body" > "$file"
dos2unix $file              #Convert text files with DOS or Mac line endings to Unix line endings

Topic=`grep URGENT $file`
Status=`grep status $file | awk '{print $3}'`
Severity=`grep severity $file | awk '{print $3}'`
item=`grep vfs.fs.size $file`
item_severity=`grep severity $file`

case $Status in
      PROBLEM)if [ $Severity = "High" ];
              then
                  for ((c=1; c<=$repeat; c++))
                  do
                     Status_Problem_High
#                     sleep $duration
                  done
              elif [ $Severity = "Disaster" ];
              then
                  for ((c=1; c<=$urgent_repeat; c++))
                  do
                     Status_Problem_Disaster
                     sleep $duration
                  done
              else
                  echo "Break"
              fi
              rm $file
              ;;
      OK)
              Status_OK
              rm $file
              ;;
      *)
              echo "No input"
              ;;
esac