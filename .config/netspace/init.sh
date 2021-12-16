#!/bin/bash
export START="sudo ip netns exec $NETSPACE"
for i in $(ls $(dirname $0)/init.d); do
	$i
done
