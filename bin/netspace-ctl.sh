#!/bin/bash
cmd=$1
ns=$2
USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)

usage()
{
	echo "usage: $(basename $0) start|stop|enter [namespace]"
}

if [ -z "$cmd" ] || [ -z "$ns" ]; then
	usage
	exit 1
fi

if [ $EUID != 0 ]; then
	echo "Netspace requires elevated privileges"
	exit 1
fi

if [ "$cmd" == "enter" ]; then
	ip netns exec $2 runuser -u $SUDO_USER bash
	exit 0
fi

if [ "$cmd" != "start" ] && [ "$cmd" != "stop" ]; then
	echo "Unrecognized command $cmd"
	exit 1
fi

export START="sudo ip netns exec $ns"

$USER_HOME/.config/netspace/init.sh
