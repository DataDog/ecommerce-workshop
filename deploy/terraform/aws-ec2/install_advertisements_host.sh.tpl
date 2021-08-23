#!/bin/bash

cat << EOF >> /home/ubuntu/.profile
export FLASK_APP=ads.py
export PATH="$HOME/.local/bin:$PATH"
export FLASK_DEBUG=1
export POSTGRES_PASSWORD=password
export POSTGRES_USER=datadog
export POSTGRES_HOST=db
export DD_SERVICE=advertisements-service
export DD_LOGS_INJECTION=true
export DD_TRACE_ANALYTICS_ENABLED=true
export DD_PROFILING_ENABLED=true
export DD_VERSION=1.1
EOF

source  /home/ubuntu/.profile

wall -n "installing"
export DEBIAN_FRONTEND=noninteractive && \
    sudo apt-get update && \
    sudo apt-get install --yes build-essential libpq-dev python3 python3-pip

wall -n 'git clone'
git clone https://github.com/DataDog/ecommerce-workshop.git
sudo ln -s /ecommerce-workshop/ads-service-fixed /app

wall -n 'datadog agent'
DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=${DD_API_KEY} DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"

cd /app
wall -n 'pip installs'
pip3 install --upgrade cython
pip3 install ddtrace
pip3 install --no-cache-dir -r requirements.txt

wall -n 'all done'
ddtrace-run flask run --port=5022 --host=0.0.0.0 &

