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
 terraform apply
