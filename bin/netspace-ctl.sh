#!/bin/bash
cmd=$1

usage()
{
	echo "usage: $(basename $0) start|stop|enter [namespace]"
}

if [ -z "$cmd" ]; then
	usage
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

# Shamelessy ripped from rc scripts
for i in $(ls -r $HOME/.config/netspace/plugin/*); do
	# Ignore dangling symlinks (if any).
	[ ! -f "$i" ] && continue

	case "$i" in
		*.sh)
		# Source shell script for speed.
		(
			trap - INT QUIT TSTP
			set start
			. $i
		)
		;;
	*)
		# No sh extension, so fork subprocess.
		$i start
		;;
	esac
done
