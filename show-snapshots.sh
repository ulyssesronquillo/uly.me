#!/bin/bash

displaysnapshots () {
  echo '--------------------------------------------------------'
  aws lightsail get-instance-snapshots --query 'instanceSnapshots[].[name]' --output text | sort
  echo '--------------------------------------------------------'
}

displaysnapshots

