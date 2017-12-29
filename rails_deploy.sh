#!/bin/bash

if [ ! $(command -v terraform) ]
then
  echo Please install terraform
  exit 1
fi
 if [ ! -z "$AWS_ACCESS_KEY_ID" ] ; then
   echo Please provide a valid AWS access key enviroment variable
   echo name should be AWS_ACCESS_KEY_ID
   exit 1
 fi

 if [ ! -z "$AWS_SECRET_ACCESS_KEY" ] ; then
   echo Please provide a valid AWS secret Key enviroment variable
   echo name should be AWS_SECRET_ACCESS_KEY
   exit 1
 fi

 terraform init 
 terraform apply -auto-approve

 ssh -oStrictHostKeyChecking=no -i ~/.ssh/id_rsa ubuntu@$(terraform output public_ip)

 sudo apt-get -y update
#install rvm rails
 gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
 cd /tmp
 curl -sSL https://get.rvm.io -o rvm.sh
 cat /tmp/rvm.sh | bash -s stable --rails
 source /home/ubuntu/.rvm/scripts/rvm
 #install nodejs(required)
 \curl -sSL https://deb.nodesource.com/setup_6.x -o nodejs.sh
 cat /tmp/nodejs.sh | sudo -E bash -
 sudo apt-get install -y nodejs
 #create hello world app
 cd ~
 rails new helloWorld
 cd helloWorld
 bin/rails server

# ssh exit
#echo $(terraform output public_ip):3000
