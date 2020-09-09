#!/bin/sh

if [ -z $DD_AGENT_HOST ] && [ -n $AWS_EXECUTION_ENV ] && [ $AWS_EXECUTION_ENV == "AWS_ECS_EC2" ]
then
    export DD_AGENT_HOST=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
fi
ddtrace-run flask run --port=5001 --host=0.0.0.0
