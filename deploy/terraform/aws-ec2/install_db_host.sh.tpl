#!/bin/bash
sudo hostname db
cat << EOF >> /home/ubuntu/.profile

EOF

source  /home/ubuntu/.profile

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic"-pgdg main | sudo tee  /etc/apt/sources.list.d/pgdg.list

sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt -y install postgresql-11
# sudo apt install postgresql -y

sudo su postgres -c 'psql -U postgres -c "CREATE ROLE datadog;"'
sudo su postgres -c 'psql -U postgres -c "ALTER ROLE  datadog  WITH LOGIN;"'
sudo su postgres -c 'psql -U postgres -c "ALTER USER  datadog  CREATEDB;"'
sudo su postgres -c "psql -U postgres -c \"ALTER USER  datadog  WITH PASSWORD 'password';\""
sudo su postgres -c "psql -U postgres -c 'CREATE DATABASE datadog'"
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/11/main/postgresql.conf
sudo bash -c "echo -e 'host\tall\t\tall\t\t0.0.0.0/0\t\tmd5' >> /etc/postgresql/11/main/pg_hba.conf"
sudo bash -c "echo -e 'host\tall\t\tall\t\t::/0\t\tmd5' >> /etc/postgresql/11/main/pg_hba.conf"
sudo systemctl restart postgresql.service

DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=${apikey} DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"
sudo sed -i "s/# logs_enabled: false/logs_enabled: true/g" /etc/datadog-agent/datadog.yaml

