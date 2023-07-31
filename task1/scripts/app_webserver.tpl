#! /bin/bash
sudo su
cd /usr/local/bin

sudo apt-get update -y

# install common tools
sudo apt-get install wget -y
sudo apt-get install git -y
sudo apt-get install dnsutils -y
sudo apt-get install jq -y
sudo apt-get install telnet -y
sudo apt-get install traceroute -y
sudo apt-get install kubectl -y
sudo apt-get install unzip -y