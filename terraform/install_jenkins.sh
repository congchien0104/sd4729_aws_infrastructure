

#!/bin/bash
echo "Install Jenkins"
sudo apt-get update -y
sudo wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt install openjdk-11-jre -y
sudo apt install jenkins -y
sudo systemctl start jenkins
sudo ufw allow 8080
sudo ufw allow OpenSSH sudo ufw enable
sudo ufw enable