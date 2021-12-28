#!/bin/sh

usage()
{
	echo "usage: $0 src user@ipaddress command"
}

src=$(readlink -f $1)
remote=$2
shift; shift
cmd="$@"
if [ -z "$src" ] || [ -z "$remote" ] || [ -z "$cmd" ]; then
	usage
	exit 1
fi

dest="~/.remote/$(basename $src)"

echo "Copying files to $remote:$dest"
ssh ${remote} "mkdir -p ${dest}"
rsync --delete -a -t --info=progress2 --include='$(git ls-files)' ${src} "${remote}:$(dirname ${dest})"

echo "Running command ${dest}$ $cmd"
ssh ${remote} "cd $dest ; $cmd"
