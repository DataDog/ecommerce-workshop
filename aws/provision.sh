#!/bin/bash
  export DEBIAN_FRONTEND=noninteractive

  apt-get -y install apt-transport-https ca-certificates curl software-properties-common

  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"

  apt-get update

  apt-get -y install docker-ce

  curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose

  apt-get -y install git wget

  mkdir /root/ecommerce-workshop

  git clone https://github.com/DataDog/ecommerce-workshop.git  /root/ecommerce-workshop

  curl -L https://github.com/buger/goreplay/releases/download/v1.0.0/gor_1.0.0_x64.tar.gz -o gor_1.0.0_x64.tar.gz
  tar -xf gor_1.0.0_x64.tar.gz
  mv gor /usr/local/bin/gor
  rm -rf gor_1.0.0_x64.tar.gz

  POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres DD_API_KEY=${var.dd_api_key} docker-compose -f /root/ecommerce-workshop/docker-compose-files/${var.docker_compose_file}.yml up -d