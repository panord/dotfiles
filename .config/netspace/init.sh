#!/bin/bash
$START /usr/sbin/dnsmasq -x /run/dnsmasq/dnsmasq.pid -u dnsmasq -7 /etc/dnsmasq.d,.dpkg-dist,.dpkg-old,.dpkg-new --local-service
$START /usr/sbin/in.tftpd --listen --user tftp --address :69 --secure /srv/tftp
