#!/bin/sh
#Script runs as root, be careful!
#Install node.js

#curl -sL https://deb.nodesource.com/setup_4.x | bash -
#apt-get -qq install -y nodejs

#Install Git
#apt-get -qq install -y git

#Install MongoDB
#apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
#echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list

#apt-get -qq update

#apt-get -qq install -y mongodb-org

service mongod start

#Clone Repo

git clone https://github.com/anjayajodha/ToDoListMean.git /ToDoListMean

cd /ToDoListMean/ToDoListMean/

#Install Dependencies
npm install

#install forever to start node in background
npm install -g forever

#Start app
forever start server.js
