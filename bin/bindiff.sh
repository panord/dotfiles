#!/bin/sh

usage()
{
	echo "$0 FILE1 FILE2"
}

if [ -z "$2" ]; then
	usage
	exit 1
fi

vimdiff <(xxd $1) <(xxd $2)
