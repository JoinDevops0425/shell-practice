#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo "Error :: PLease run with root access"
    exit 1
else 
    echo "You are root user"
fi

dnf list installed mysql

if [ $? -ne 0 ]
then 
    echo "Mysql is not installed ..going to install"
    dnf install mysql -y
    if [ $? -eq 0 ]
    then 
        echo "Mysql is installed"
    else 
        echo "Mysql is not installed"
        exit 1  
else 
    echo "Mysql is already installed"
fi