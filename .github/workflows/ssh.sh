#!/bin/bash

remote_host="192.168.102.238"
remote_user="devops"
ssh_key="$PRIVATE_KEY"

mkdir -p ~/.ssh
echo"$ssh_key" > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa
ssh -i ~/.ssh/id_rsa "devops@${remote_host}""echo 'hello form remote'; ls -l "