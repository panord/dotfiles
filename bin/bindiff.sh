#!/bin/bash

usage()
{
	echo "$0 FILE1 FILE2"
}

if [ -z "$2" ]; then
	usage
	exit 1
fi

binwalk -W $1 $2
