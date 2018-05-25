#!/bin/bash
set -e

wget $REMOTE_APPSETTINGS -O /opt/app-root/src/conf/tmp.txt

md5sum /opt/app-root/src/conf/tmp.txt > /opt/app-root/src/conf/tmp.txt.md5

if [ ! -e "/opt/app-root/src/conf/default.json.md5" ] ; then
    touch "/opt/app-root/src/conf/default.json.md5"
fi

if ! comm -3 <(sort /opt/app-root/src/conf/tmp.txt.md5) <(sort /opt/app-root/src/conf/default.json.md5) | grep -q '.*'; then
   echo "There are no changes in the conf files"
else
    cp /opt/app-root/src/conf/tmp.txt /opt/app-root/src/conf/default.json
    cp /opt/app-root/src/conf/tmp.txt.md5 /opt/app-root/src/conf/default.json.md5
fi