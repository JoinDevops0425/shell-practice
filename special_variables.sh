#!/bin/bash

echo "All variables passed to the script are : $@, $*"
echo "Number of variables $#"
echo "Script name $0"
echo "Current directory $PWD"
echo " User running the script $USER"
echo "Home directory $HOME"
echo "PID of the script $$"
sleep 10 &
echo "PID of the last command in background $!"