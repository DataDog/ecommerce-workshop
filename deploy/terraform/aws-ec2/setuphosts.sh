#!/bin/bash
privateip=$1
publicip=$2
loginname=$3
hostname=$4
hosts='internalhostsfile'
sshstring="$loginname@$publicip"

echo $privateip $hostname >> $hosts
echo checkssh $loginname $publicip >> run.sh
echo scp -oStrictHostKeyChecking=no -i ecommerceapp $hosts $sshstring:/home/$loginname/hosts >> run.sh
echo ssh -oStrictHostKeyChecking=no -i ecommerceapp $sshstring sudo mv /home/$loginname/hosts /etc/hosts >> run.sh 
echo ssh -oStrictHostKeyChecking=no -i ecommerceapp $sshstring sudo hostname $hostname >> run.sh