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

mkdir -p $LOGS_FOLDER

echo "script started executed at : $(date)" &>>$LOG_FILE


if [ $USERID -ne 0 ]
then 
    echo -e "$R Error :: $N PLease run with root access" &>>$LOG_FILE
    exit 1
else 
    echo -e "$G You are root user$N" &>>$LOG_FILE
fi

VALIDATE(){
    if [ $1 -eq 0 ]
    then 
        echo "$2 is $G installed $N" &>>$LOG_FILE
    else 
        echo "$2 is $R not installed $N" &>>$LOG_FILE
        exit 1
    fi 
}

dnf list installed mysql


if [ $? -ne 0 ]
then 
    echo -e "Mysql is not installed ..$G going to install$N" &>>$LOG_FILE
    dnf install mysql -y
    VALIDATE $? "MYSQL"
else 
    echo -e "Mysql is already $G installed$N" &>>$LOG_FILE
fi



dnf list installed nginx


if [ $? -ne 0 ]
then 
    echo -e "nginx is not $R installed ..$G going to install $N" &>>$LOG_FILE
    dnf install nginx -y
    VALIDATE $? "NGINX"
else  
    echo -e "nginx is already $Y installed $N" &>>$LOG_FILE
fi

dnf list installed python3


if [ $? -ne 0 ]
then 
    echo -e "pythonn3 is not installed ..going to install" &>>$LOG_FILE
    dnf install mysql -y
    VALIDATE $? "PYTHON3"
else 
    echo -e "python3 is already $Y installed $N" &>>$LOG_FILE
fi