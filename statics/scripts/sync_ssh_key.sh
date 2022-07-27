#!/bin/bash

# @Time    : 2019-01-10 15:22
# @Author  : 小贰
# @FileName: sync_ssh_key.sh
# @function: sync ssh key to remote host

user=$1
pass=$2
host=$3

sshpass -p$pass ssh-copy-id -i /root/.ssh/id_rsa.pub $user@$host