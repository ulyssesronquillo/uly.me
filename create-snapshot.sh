#!/bin/bash

# 
# format: create-snapshot.sh name daily
#

name=$1
prefix=$2
region='us-east-2'

if [ $# -eq 2 ]; then
  timestamp=$(date +%s)
  snapshotname=$prefix'_'$name'_'$timestamp
  /usr/bin/aws lightsail create-instance-snapshot \
  --instance-snapshot-name $snapshotname \
  --instance-name $name
else
  echo 'Need two arguments. create.sh name weekly'
fi

