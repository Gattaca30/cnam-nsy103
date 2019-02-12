#!/bin/sh

ip=$(getent hosts docker.for.mac.host.internal &> /dev/null && getent hosts docker.for.mac.host.internal | awk '{ print $1 }')
test -n "$ip" && BACKEND=$ip

if ping -c 2 10.0.75.1 &> /dev/null ; then
    BACKEND=10.0.75.1
elif ping -c 2 192.168.99.1 &> /dev/null ; then
    BACKEND=192.168.99.1
fi

set -e 
