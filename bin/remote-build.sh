#!/bin/bash

usage()
{
	echo "usage: $0 src out dest user@ipaddress command"
}

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
	usage
	exit 1
fi


src=$(readlink -f $1)
out=$2
dest=$3
remote=$4
shift; shift; shift; shift;

cmd="$@"
if [ -z "$cmd" ]; then
	usage
	exit 1
fi

builddir="~/.remote/"
rsrc=${builddir}/$(basename $src)
rbuilddir="${remote}:${builddir}"

echo "Remote build of ${src} on ${remote}"
echo -e "\tBuild dir ${builddir}"
echo -e "\tOutput    ${dest}"
echo -e "\tCommand   ${cmd}"

echo "Copying files to ${rbuilddir}"
ssh ${remote} "mkdir -p ${builddir}"

rsync --delete -a -t --info=progress2 --include='$(git ls-files)' ${src} "${rbuilddir}"

echo "Running command ${rsrc}$ $cmd"
ssh ${remote} "cd ${rsrc} ; $cmd"

echo "Copying output from ${rbuilddir}/$(basename $src)/$out to ${dest}"
rsync --delete -a -t --info=progress2 ${rbuilddir}/$(basename $src)/$out ${dest}
