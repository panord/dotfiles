yorn()
{
	while true; do
		read -p "$* [y/N]: " yn
		case $yn in
			[Yy]*) return 0;;
			[Nn]*) return 1;;
			*) return 0;;
		esac
	done
}

usage()
{
	echo "usage: $0 hostname port [target]"
	echo "example: $0 mydomain.com 443 example.pem"
}

hostname=$1
port=$2

if [ -z "$hostname" ] || [ -z "$port" ]; then
	usage
	exit 1
fi

if [ -z "$3" ]; then
	target_cert=$(curl-config --ca)
else
	target_cert=$3
fi

if [ -z "$target_cert" ]; then
	echo "Could not find default certificate target curl-config --ca"
	exit 1
fi

resp=$(echo "^D" | openssl s_client -showcerts -connect $hostname:$port -servername $hostname 2>/dev/null)
cert=$(echo "$resp" | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p')
echo -e "Extracting cert from response...\n\tResponse\n${resp}\n\tCert\n${cert}"

if yorn "Save certificate to ${target_cert}?"; then
	echo "$cert" >> ${target_cert}
fi
