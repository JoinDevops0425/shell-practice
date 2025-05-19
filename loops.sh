#!/bin/bash

#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
PACKAGES=("mysql" "nginx" "httpd")

mkdir -p $LOGS_FOLDER

echo "script started executed at : $(date)" | tee -a $LOG_FILE


if [ $USERID -ne 0 ]
then 
    echo -e "$R Error :: $N PLease run with root access" | tee -a $LOG_FILE
    exit 1
else 
    echo -e "$G You are root user$N" | tee -a $LOG_FILE
fi

VALIDATE(){
    if [ $1 -eq 0 ]
    then 
        echo "$2 is $G installed $N" | tee -a $LOG_FILE
    else 
        echo "$2 is $R not installed $N" | tee -a $LOG_FILE
        exit 1
    fi 
}

for package in $@ #${PACKAGES[@]}
do 
    dnf list installed $package &>>LOG_FILE
    if [ $? -ne 0 ]
    then 
        echo -e "$package is not installed ..$G going to install$N" | tee -a $LOG_FILE
        dnf install $package -y
        VALIDATE $? "$package"
    else 
        echo -e "$package is already $G installed$N" | tee -a $LOG_FILE
    fi
done
