resource "aws_instance" "jenkins-devops" {
  ami = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  key_name = "jenkinskey"
  vpc_security_group_ids = ["${aws_security_group.sg-devops.id}"]
  subnet_id = "${aws_subnet.public-subnet-1.id}"
  #user_data = "${file("install_jenkins.sh")}"

  associate_public_ip_address = true
  tags = {
    Name = "Jenkins-DevOps"
  }
}

resource "aws_security_group" "sg-devops" {
  name = "allow_jenkins"
  description = "Allow ssh and jenkins inbound traffic"
  vpc_id = "${aws_vpc.development-vpc.id}"

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

output "jenkisn_ip_address" {
  value = "${aws_instance.jenkins-devops.public_dns}"
}