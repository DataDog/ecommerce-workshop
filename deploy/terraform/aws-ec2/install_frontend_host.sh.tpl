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

# gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
# 7D2BAF1CF37B13E2069D6956105BD0E739499BDB


wall -n "installing"
export DEBIAN_FRONTEND=noninteractive && \
    sudo apt-get update && \
    sudo apt-get install -y --no-install-recommends curl build-essential git-core libsqlite3-dev libpq-dev ruby && \
    curl -sL https://deb.nodesource.com/setup_12.x | sudo bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    sudo apt-get update && \
    sudo apt-get install -y nodejs yarn && \

# curl -sSL https://get.rvm.io | bash -s stable --ruby
# source /home/ubuntu/.rvm/scripts/rvm
# rvm get stable --autolibs=enable
# usermod -a -G rvm root
# rvm install 2.7
# curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
# sudo apt install -y nodejs
# sudo apt install gcc g++ make
# echo "gem: --no-document" >> ~/.gemrc
# gem update --system
# gem install rails -v 5.2.0
# sudo apt install postgresql postgresql-contrib libpq-dev -y
# sudo systemctl start postgresql
# sudo systemctl enable postgresql


wall -n 'git clone'
cd /
sudo git clone https://github.com/DataDog/ecommerce-workshop.git
sudo chown -R bitnami /ecommerce-workshop
sudo ln -s /ecommerce-workshop/store-frontend-instrumented-fixed /app

# sudo apt-get remove python3-pip -y; sudo apt-get install python3-pip -y 

wall -n 'datadog agent'
DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=${apikey} DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"

sudo sed -i "s/# logs_enabled: false/logs_enabled: true/g" /etc/datadog-agent/datadog.yaml

cd /app
find . -type f -name "*.rb" -printev0 | xargs -0 sed -i '' -e 's/advertisements:5002/advertisements:5022/g'
find . -type f -name "*.rb" -print0 | xargs -0 sed -i '' -e 's/discounts:5001/discounts:5011/g'
# sed replace 2.7.2 to 2.7.3 in Gemfile
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

