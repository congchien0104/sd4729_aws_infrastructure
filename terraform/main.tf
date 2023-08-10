provider "aws" {
  region = "${var.region}"
}

# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 4.16"
#     }
#   }

#   required_version = ">= 1.2.0"
# }

# provider "aws" {
#   region = "us-east-1"
# }

# # Creat VPC
# resource "aws_vpc" "todo-vpc" {
#   cidr_block = "10.0.0.0/16"
#   tags = {
#     Name = "production"
#   }
# }

# # Create Internet Gateway
# resource "aws_internet_gateway" "gw" {
#   vpc_id = aws_vpc.todo-vpc.id

# }

# # Create Custom Route Table
# resource "aws_route_table" "todo-route-table" {
#   vpc_id = aws_vpc.todo-vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.gw.id
#   }

#   route {
#     ipv6_cidr_block        = "::/0"
#     gateway_id = aws_internet_gateway.gw.id
#   }

#   tags = {
#     Name = "Prod"
#   }
# }

# # Create a Subnet
# resource "aws_subnet" "subnet-1" {
#   vpc_id = aws_vpc.todo-vpc.id
#   cidr_block = "10.0.1.0/24"
#   availability_zone = "us-east-1a"

#   tags = {
#     Name = "prod-subnet"
#   }
# }

# # Associate subnet with route table
# resource "aws_route_table_association" "a" {
#   subnet_id      = aws_subnet.subnet-1.id
#   route_table_id = aws_route_table.todo-route-table.id
# }

# # Create Security Group
# resource "aws_security_group" "allow_web" {
#   name        = "allow_web_traffic"
#   description = "Allow Web inbound traffic"
#   vpc_id      = aws_vpc.todo-vpc.id

#   ingress {
#     description      = "HTTPS"
#     from_port        = 443
#     to_port          = 443
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   ingress {
#     description      = "HTTP"
#     from_port        = 8080
#     to_port          = 8080
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   ingress {
#     description      = "SSH"
#     from_port        = 2
#     to_port          = 2
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "allow_web"
#   }
# }

# # Create Network Interface with an ip in the subnet that was created in step 4
# resource "aws_network_interface" "web-server-nic" {
#   subnet_id       = aws_subnet.subnet-1.id
#   private_ips     = ["10.0.1.50"]
#   security_groups = [aws_security_group.allow_web.id]

# }

# # Assign an elastic IP to the network interface created in step7
# resource "aws_eip" "one" {
#   vpc                       = true
#   network_interface         = aws_network_interface.web-server-nic.id
#   associate_with_private_ip = "10.0.1.50"
#   depends_on = [ aws_internet_gateway.gw ]
# }

# # Create Ubuntu server and install jenkins and docker
# resource "aws_instance" "web-server-instance" {
#     ami = "ami-053b0d53c279acc90"
#     instance_type = "t2.micro"
#     availability_zone = "us-east-1a"
#     key_name = "main-key"

#     network_interface {
#       device_index = 0
#       network_interface_id = aws_network_interface.web-server-nic.id
#     }

#     tags = {
#       Name = "Todo-Server"
#     }
# }

# # an empty resource block
# resource "null_resource" "name" {

#   # ssh into the ec2 instance 
#   connection {
#     type        = "ssh"
#     user        = "ec2-user"
#     private_key = file("./main-key.pem")
#     host        = aws_instance.web-server-instance.public_ip
#   }

#   # copy the install_jenkins.sh file from your computer to the ec2 instance 
#   provisioner "file" {
#     source      = "install_jenkins.sh"
#     destination = "/tmp/install_jenkins.sh"
#   }

#   # set permissions and run the install_jenkins.sh file
#   provisioner "remote-exec" {
#     inline = [
#         "sudo chomod +x /tmp/install_jenkins.sh",
#         "sh /tmp/install_jenkins.sh",
#     ]
#   }

#   # wait for ec2 to be created
#   depends_on = [aws_instance.web-server-instance]
# }


# # print the url of the jenkins server
# output "website_url" {
#   value     = join ("", ["http://", aws_instance.web-server-instance.public_dns, ":", "8080"])
# }

