#!/bin/sh

ARGS="-a 0.0.0.0"
if test -e /boot/configs/dmdserver.ini
then
    ARGS="${ARGS} -c /boot/configs/dmdserver.ini"
else
    ARGS="${ARGS} -c /usr/share/dmdserver/default-config.ini"
fi

while true
do
    /usr/bin/dmdserver ${ARGS}
    sleep 15 # wait before retrying. the dmd could be on a remote ip
done
