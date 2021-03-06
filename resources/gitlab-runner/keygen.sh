#!/usr/bin/env bash
[ -d keys ] || mkdir keys
echo "[runners]" > hosts
for var in "$@" 
do 
    vagrant ssh-config ${var} > result.txt
    identityFile=`cat result.txt | awk '/IdentityFile/' | awk  -F " " '{ print $2 }'`
    port=`cat result.txt | awk '/Port/' | awk  -F " " '{ print $2 }'`
    [ -f keys/${var}_private_key ] && > keys/${var}_private_key
    cp ${identityFile} keys/${var}_private_key
    line="${var} ansible_ssh_host=127.0.0.1 ansible_ssh_port=${port} ansible_ssh_user=vagrant ansible_ssh_private_key_file=keys/${var}_private_key"
    echo ${line} >> hosts
    echo "[${line}] add to hosts file"
done
