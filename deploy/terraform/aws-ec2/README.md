# AWS EC2

This terraform module sets up and configures the app to run on EC2 instances. This was specifically created to have something to migrate from in the monitoring kubernetes workloads course.

## Initial setup

- aws-vault or env vars setup

1. Clone this repo to a local folder.
1. These instructions assume you have setup an account with AWS and have the keys in your environment variables. If you have a lot of accounts to manage, look into using **aws-vault**.
1. Navigate to this directory in the newly cloned local repo. Run `terraform init` to install the extensions to terraform used.
1. Create an SSH key to use to connect to the EC2's created. `ssh-keygen -f ecommerceapp -N ""` will create a key named ecommerceapp with no passphrase. Run the command in the same directory you cloned this to.
1. Edit `variables.tf` file
   1. Set **instance_type** to the instance type you want to use. It is currently set to `t2.medium`. To change it, set the string value for default to whatever you want it to be.
   1. Set **region** to the AWS region you want to use. If you change the region you will also need to change the values for mainami and rubyami. AMI's are region specific. See below for details on the two AMI's used.
   1. Set **keyname** to the name of the key you created above.
   1. Set **owner** to your name. If others run this Terraform, it will keep them separate.
1. Collect your api keys. Go to the Datadog UI and make note of your apikey and appkey, then create a new RUM application and copy your app id and the client token. You can pass that to Terraform in one of two ways:
   1. Set environment variables for **TF_VAR_ddapikey**, **TF_VAR_ddappkey**, **TF_VAR_rummappid**, **TF_VAR_clienttoken** based on what you collected.
   2. Or Terraform will ask you to fill in the values when you run apply.
1. Terraform apply will create a shell script called `run.sh` which you can run after apply is complete. This will setup the hosts file on each machine so they can talk to each other. To apply and run this script together, run: `terraform apply -auto-approve;./run.sh`
1. The run.sh command tries to repeatedly connect to each EC2 until sshd is ready, so you will see a bunch of 'connection refused errors until it connects. It should take less than a minute to complete.
1. After the script completes, it will still take upwards of 5 minutes to spin everything up in the EC2's. Be patient.

I haven't been able to figure out how to get puma to start automatically, so you will need to ssh into the frontend box, cd to /app and then run `bundle exec puma --config config/puma.rb`

## AMIs used

| variable | ami                   | name                                                            | region    |
| -------- | --------------------- | --------------------------------------------------------------- | --------- |
| mainami  | ami-0121ef35996ede438 | ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-20210224 | us-west-1 |
| rubyami  | ami-072df871c83814231 | bitnami-ruby-2.7.2-68-r55-linux-debian-10-x86\_64-hvm-ebs-nami  | us-west-1 |
|          |                       |                                                                 |           |