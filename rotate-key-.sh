#!/bin/bash

setfiles () {
  user='lightsail'
  newkey='/root/new-access-key.json'
  oldkey='/root/old-access-key.json'
  credentials='/root/.aws/credentials'
}

getoldcredentials () {
  aws iam list-access-keys --user-name $user > $oldkey
  oldkeyid=$(jq .AccessKeyMetadata[0].AccessKeyId $oldkey | tr -d \")
}

createnewkey () {
  aws iam create-access-key --user-name $user > $newkey
}

getnewcredentials () {
  newkeyid=$(jq .AccessKey.AccessKeyId $newkey | tr -d \")
  newsecret=$(jq .AccessKey.SecretAccessKey $newkey | tr -d \")
}

backupoldcredentials () {
  cp /root/.aws/credentials /root/.aws/credentials-backup
}

storenewkey () {
  echo '[default]' > $credentials
  echo 'aws_access_key_id = ' $newkeyid >> $credentials
  echo 'aws_secret_access_key = '$newsecret >> $credentials
  sleep 10
}

deleteoldkey () {
  aws iam delete-access-key --user-name $user --access-key-id $oldkeyid
}

cleanup () {
  rm $newkey
  rm $oldkey
}

setfiles
getoldcredentials
createnewkey
getnewcredentials
backupoldcredentials
storenewkey
deleteoldkey
cleanup

