resource "null_resource" "setup" {
  provisioner "local-exec" {
    command = "rm internalhostsfile;rm run.sh;cp runshtemplate run.sh;chmod +x run.sh"
  }
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.34"
    }
  }
}

resource "aws_key_pair" "ecommerceapp-key" {
  key_name   = var.keyname
  public_key = file("${var.keyname}.pub")
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "discounts" {
  ami                    = "ami-0121ef35996ede438"
  subnet_id              = aws_subnet.ecommerceapp-subnet.id
  vpc_security_group_ids = [aws_security_group.ecommerceapp-sg.id]
  instance_type          = var.instance_type
  # user_data              = file("install_discounts_host.sh")
  user_data = templatefile("install_discounts_host.sh.tpl", { DD_API_KEY = var.ddapikey })
  key_name  = aws_key_pair.ecommerceapp-key.key_name
  tags = {
    Name  = "ecm-discounts"
    Owner = var.owner
  }

  provisioner "local-exec" {
    command = "./setuphosts.sh ${aws_instance.discounts.private_ip} ${aws_instance.discounts.public_ip} ubuntu discounts"
  }

}

resource "aws_instance" "frontend" {
  ami                    = "ami-072df871c83814231"
  subnet_id              = aws_subnet.ecommerceapp-subnet.id
  vpc_security_group_ids = [aws_security_group.ecommerceapp-sg.id]
  instance_type          = var.instance_type
  user_data              = templatefile("install_frontend_host.sh.tpl", { clienttoken = var.clienttoken, appid = var.rumappid, apikey = var.ddapikey })
  key_name               = aws_key_pair.ecommerceapp-key.key_name
  tags = {
    Name  = "ecm-frontend"
    Owner = var.owner
  }
  provisioner "local-exec" {
    command = "./setuphosts.sh ${aws_instance.frontend.private_ip} ${aws_instance.frontend.public_ip} bitnami frontend"
  }
}

resource "aws_instance" "advertisements" {
  ami                    = "ami-0121ef35996ede438"
  subnet_id              = aws_subnet.ecommerceapp-subnet.id
  vpc_security_group_ids = [aws_security_group.ecommerceapp-sg.id]
  instance_type          = var.instance_type
  user_data              = templatefile("install_advertisements_host.sh.tpl", { DD_API_KEY = var.ddapikey })
  key_name               = aws_key_pair.ecommerceapp-key.key_name
  tags = {
    Name  = "ecm-advertisements"
    Owner = var.owner
  }
  provisioner "local-exec" {
    command = "./setuphosts.sh ${aws_instance.advertisements.private_ip} ${aws_instance.advertisements.public_ip} ubuntu advertisements"
  }
}

resource "aws_instance" "db" {
  ami                    = "ami-0121ef35996ede438"
  subnet_id              = aws_subnet.ecommerceapp-subnet.id
  vpc_security_group_ids = [aws_security_group.ecommerceapp-sg.id]
  instance_type          = var.instance_type
  # user_data              = file("install_discounts_host.sh")
  user_data = templatefile("install_db_host.sh.tpl", { apikey = var.ddapikey })
  key_name  = aws_key_pair.ecommerceapp-key.key_name
  tags = {
    Name  = "ecm-discounts"
    Owner = var.owner
  }

  provisioner "local-exec" {
    command = "./setuphosts.sh ${aws_instance.db.private_ip} ${aws_instance.db.public_ip} ubuntu db"
  }

}
