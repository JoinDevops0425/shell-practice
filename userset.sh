#!/bin/bash
set -e

failure(){
 echo "Failed at $1 $2"
}

trap 'failure "${LINENO}" "${BASH_COMMAND}"' ERR

START_TIME=$(date +%s)

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/roboshop-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"


SCRIPT_DIR=$PWD

mkdir -p $LOGS_FOLDER
echo "Script started executeing at : $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ]
then 
    echo -e "$R Error : Please run as a root user$N" | tee -a $LOG_FILE
    exit 1
else 
    echo "You are running as a root user" | tee -a $LOG_FILE
fi



dnf module disable nodejs -y &>>$LOG_FILE


dnf module enable nodejs:20 -y &>>$LOG_FILE


dnf install nodejfffs -y &>>$LOG_FILE


mkdir -p /opt/app

curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user-v3.zip 


rm -rf /opt/app/*
cd /opt/app
unzip /tmp/user.zip &>>$LOG_FILE


npm install &>>$LOG_FILE


id roboshop
if [ $? -ne 0 ]
then 
    useradd --system --home /opt/app --shell /sbin/nologin --comment "System User" roboshop
else 
    echo "Roboshop user is already created"
fi 

cp $SCRIPT_DIR/user.service /etc/systemd/system/user.service


systemctl daemeon-reload &>>$LOG_FILE

systemctl enable user &>>$LOG_FILE


systemctl start user &>>$LOG_FILE


END_TIME=$(date +%s)
TOTAL_TIME=$(( $END_TIME - $START_TIME ))

echo "Script executed in $TOTAL_TIME seconds" | tee -a $LOG_FILE