#!/bin/bash

if [ $# -ne 1 ]; then
    read -p "Please enter your key name: " RSA_NAME
else
    RSA_NAME=$1
fi

RSA_FILE=$HOME/.ssh/$RSA_NAME/$RSA_NAME

# create ssh directory
mkdir -pv $HOME/.ssh/$RSA_NAME

if [ -f  "$RSA_FILE" ]; then
    echo "$RSA_FILE already exists."
else
    # GENERATE KEY PAIR
    while true; do
        read -p "Please enter your github email adress:" mail
        case $mail in
            *@*.* ) ssh-keygen -f "$RSA_FILE" -t rsa -b 4096 -C "$mail"; break;;
            * ) echo "Please enter a valid email adress.";;
        esac
    done

   # ADD KEY PAIR TO AGENT 
   eval "$(ssh-agent -s)"
   ssh-add $RSA_FILE
fi
