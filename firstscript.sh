#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo "Error :: PLease run with root access"
    exit 1
else 
    echo "You are root user"
fi

dnf install 7iehufe -y

if [ $? -eq 0 ]
then 
     echo "INstalling mysql"
else
     echo "installing mysql is failure"
     exit 1
fi