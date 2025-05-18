#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo "Error :: PLease run with root access"
    exit 1
else 
    echo "You are root user"
fi

VALIDATE(){
    if [ $1 -eq 0 ]
    then 
        echo "$2 is installed"
    else 
        echo "$2 is not installed"
        exit 1
    fi 
}

dnf list installed mysql


if [ $? -ne 0 ]
then 
    echo "Mysql is not installed ..going to install"
    dnf install mysql -y
    VALIDATE $? "MYSQL"
else 
    echo "Mysql is already installed"
fi

dnf list installed nginx


if [ $? -ne 0 ]
then 
    echo "nginx is not installed ..going to install"
    dnf install nginx -y
    VALIDATE $? "NGINX"
else 
    echo "nginx is already installed"
fi

dnf list installed python3


if [ $? -ne 0 ]
then 
    echo "pythonn3 is not installed ..going to install"
    dnf install mysql -y
    VALIDATE $? "PYTHON3"
else 
    echo "python3 is already installed"
fi