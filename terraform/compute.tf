resource "aws_instance" "devops-ec2" {
  ami = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  key_name = "jenkinskey"
  vpc_security_group_ids = ["${aws_security_group.devops-sg.id}"]
  subnet_id = "${aws_subnet.public-subnet-1.id}"
  #user_data = "${file("install_jenkins.sh")}"

  associate_public_ip_address = true
  tags = {
    Name = "DevOps-EC2"
  }
}

resource "aws_security_group" "devops-sg" {
  name = "allow_jenkins"
  description = "Allow ssh and jenkins inbound traffic"
  vpc_id = "${aws_vpc.devops-vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "jenkins_ip_address" {
  value = "${aws_instance.devops-ec2.public_dns}"
}