#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo "Error :: PLease run with root access"
else 
    echo "You are root user"
fi

dnf install mysql -y
