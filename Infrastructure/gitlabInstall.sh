#!/bin/bash


dns=$1


export DEBIAN_FRONTEND=noninteractive
apt-get -y install curl openssh-server ca-certificates 

curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash

sudo apt-get install gitlab-ce

sed '2,/external_url/d' /etc/gitlab/gitlab.rb -i
echo "external_url 'http://$dns/'" >> /etc/gitlab/gitlab.rb


sudo gitlab-ctl reconfigure