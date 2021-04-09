# AWS EC2 

This terraform module sets up and configures the app to run on EC2 instances. This was specifically created to have something to migrate from in the monitoring kubernetes workloads course.

## Initial setup 

- aws-vault or env vars setup

1. Clone this repo to a local folder.
1. These instructions assume you have setup an account with AWS and have the keys in your environment variables. If you have a lot of accounts to manage, look into using **aws-vault**.
1. In the new directory, run `terraform init` to install the extensions to terraform used.
1. Create an SSH key to use to connect to the EC2's created. `ssh-keygen -f ecommerceapp -N ""` will create a key named ecommerceapp with no passphrase. Run the command in the same directory you cloned this to.
2. Edit `variables.tf` file
    1. Set **instance_type** to the instance type you want to use. It is currently set to `t2.medium`. To change it, set the string value for default to whatever you want it to be.
    1. Set **keyname** to the name of the key you created above. 
    1. Set **owner** to your name. If others run this Terraform, it will keep them separate.
3. Collect your api keys. Go to the Datadog UI and make note of your apikey and appkey, then create a new RUM application and copy your app id and the client token. You can pass that to Terraform in one of two ways:
    1. Set environment variables for **TF_VAR_ddapikey**, **TF_VAR_ddappkey**, **TF_VAR_rummappid**, **TF_VAR_clienttoken** based on what you collected.
    2. Or Terraform will ask you to fill in the values when you run apply.
4.  Terraform apply will create a shell script called `run.sh` which you can run after apply is complete. This will setup the hosts file on each machine so they can talk to each other. To apply and run this script together, run: `terraform apply -auto-approve;./run.sh`