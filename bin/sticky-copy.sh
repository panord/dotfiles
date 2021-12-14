#!/bin/sh
usage()
{
	echo "usage: $0 [src] [dest] [file]"
	echo "example: $0 build root@tftpserver:/srv/tftp *.img"
}

src=$1
dest=$2
ptrn=$3


if [ -z "$src" ] || [ -z "$dest" ]; then
	usage
	exit 1
fi

if [ -z "$ptrn" ]; then
	ptrn="*"
fi

inotifywait -msr -e close_write "$src" | while read line
do
	f=$(echo $line | cut -d ' ' -f 3)
	if echo "$f" | egrep "$ptrn"; then
		scp $src/$f $dest/
		chmod a+r $dest/$f
	fi
done
