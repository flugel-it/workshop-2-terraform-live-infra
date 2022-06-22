#!/bin/bash

if [[ $# -eq 0 ]] ; then
  echo "Remember to run the command with the environment to be modified."
  echo "Usage: initialize.sh <environment>"
  exit 1
fi

environment=$1
resources=("vpc" "ec2")
pwd=$(pwd)

# Initialize all the modules
for i in "${resources[@]}"
  do cd $pwd/$environment/$i && echo "Y"| terragrunt init -reconfigure -force-copy -get=true -get-plugins=true
done