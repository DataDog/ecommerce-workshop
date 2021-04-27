#!/bin/bash

cat << EOF >> /home/bitnami/.profile
export DD_SERVICE=store-frontend
export DD_LOGS_INJECTION=true
export DD_TRACE_ANALYTICS_ENABLED=true
export DB_USERNAME=datadog
export DB_PASSWORD=password
export DD_CLIENT_TOKEN=${clienttoken}
export DD_APPLICATION_ID=${appid}
EOF

source  /home/bitnami/.profile


wall -n "installing"
export DEBIAN_FRONTEND=noninteractive && \
    sudo apt-get update && \
    sudo apt-get install -y --no-install-recommends curl build-essential git-core libsqlite3-dev libpq-dev ruby && \
    curl -sL https://deb.nodesource.com/setup_12.x | sudo bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    sudo apt-get update && \
    sudo apt-get install -y nodejs yarn 

wall -n 'git clone'
cd /
sudo git clone https://github.com/DataDog/ecommerce-workshop.git
sudo chown -R bitnami /ecommerce-workshop
sudo ln -s /ecommerce-workshop/store-frontend-instrumented-fixed /app

wall -n 'datadog agent'
DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=${apikey} DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"

sudo sed -i "s/# logs_enabled: false/logs_enabled: true/g" /etc/datadog-agent/datadog.yaml

cd /app
find . -type f -name "*.rb" -print0 | xargs -0 sed -i '' -e 's/advertisements:5002/advertisements:5022/g'
find . -type f -name "*.rb" -print0 | xargs -0 sed -i '' -e 's/discounts:5001/discounts:5011/g'

bundle install && yarn install

sudo sh -c "cat << EOF > /etc/systemd/system/puma.service
[Unit]
Description=Puma HTTP Server
After=network.target

[Service]
Type=simple
User=bitnami
WorkingDirectory=/app
ExecStart=/opt/bitnami/ruby/bin/bundle exec puma --config /app/config/puma.rb
PIDFile=/app/puma.pid
Restart=always
StartLimitBurst=0

[Install]
WantedBy=multi-user.target
EOF"


sudo systemctl daemon-reload
sudo systemctl enable --now  --no-block puma.service
# sudo systemctl start puma.service
sudo systemctl status puma.service

wall -n 'all done'

