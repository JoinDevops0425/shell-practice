#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


if [ $USERID -ne 0 ]
then 
    echo -e "$R Error :: $N PLease run with root access"
    exit 1
else 
    echo -e "$G You are root user$N"
fi

VALIDATE(){
    if [ $1 -eq 0 ]
    then 
        echo "$2 is $G installed $N"
    else 
        echo "$2 is $R not installed $N"
        exit 1
    fi 
}

dnf list installed mysql


if [ $? -ne 0 ]
then 
    echo -e "Mysql is not installed ..$G going to install$N"
    dnf install mysql -y
    VALIDATE $? "MYSQL"
else 
    echo -e "Mysql is already $G installed$N"
fi



dnf list installed nginx


if [ $? -ne 0 ]
then 
    echo -e "nginx is not $R installed ..$G going to install $N"
    dnf install nginx -y
    VALIDATE $? "NGINX"
else 
    echo -e "nginx is already $Y installed $N"
fi

dnf list installed python3


if [ $? -ne 0 ]
then 
    echo -e "pythonn3 is not installed ..going to install"
    dnf install mysql -y
    VALIDATE $? "PYTHON3"
else 
    echo -e "python3 is already $Y installed $N"
fi