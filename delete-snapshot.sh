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
root@ulyme:~# cat delete-snapshot.sh 
#!/bin/bash

# set variables
current=$(date +%s)

# 6 hour retention
hourlyretention='10800'

# 7 day retention
dailyretention='604800'

# 4 week retention
weeklyretention='2419200'

# 6 month retention
monthlyretention='15552000'

# set filenames
snaps='/root/snapshots.json'
names='/root/names.txt'
parse='/root/parse.txt'
logfile='/root/logs/snapshots.log'


# exit if no arguments
if [ $# -eq 0 ]; then
  exit 1
fi

# set expired dates
if [[ $1 = 'hourly' ]]; then
  prefix='hourly'
  expired=$(($current-$hourlyretention))
elif [[ $1 = 'daily' ]]; then
  prefix='daily'
  expired=$(($current-$dailyretention))
elif [[ $1 = 'weekly' ]]; then
  prefix='weekly'
  expired=$(($current-$weeklyretention))
elif [[ $1 = 'monthly' ]]; then
  prefix='monthly'
  expired=$(($current-$monthlyretention))
else
  exit 1
fi

# get list of snapshots
/usr/bin/aws lightsail get-instance-snapshots > $snaps
cat $snaps | jq -r '.instanceSnapshots[] | .name' > $names
cat $names | grep $prefix > $parse

# read snapshots
while read -r line; do

  # get epoch time from name
  snapshot=$(echo $line | cut -d_ -f3)

  # set snapshotname
  snapshotname=$line

  # check if numeric
  if [ `expr $snapshot + 1 2> /dev/null` ] ; then

    # compare if snapshot is expired
    if [ $snapshot -le $expired ]; then

      # delete snapshot if expired. log it
      echo 'Deleted: '$snapshotname >> $logfile
      /usr/bin/aws lightsail delete-instance-snapshot --instance-snapshot-name $snapshotname

    else

      # nothing to delete if not expired. log it
      echo 'Nothing: '$snapshotname >> $logfile

    fi

  # not numeric
  else
    echo $snapshot is not numeric > /dev/null
  fi

# we are done here
done < $parse

#now=$(date -s @$current)
#exp=$(date -s @$expired)

# log it
echo 'Current time: '$current >> $logfile
echo 'Expired time: '$expired >> $logfile
echo '-----------------------------------' >> $logfile

# clean up
rm $snaps
rm $names
rm $parse

