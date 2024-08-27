> 
> DNSMASQ is a lightweight, easy-to-configure DNS forwarder and DHCP server designed to provide DNS and optionally
> DHCP services to a small-scale network. It's particularly well-suited for resource-constrained devices like routers and firewalls.
> <a href="https://docs.fedoraproject.org/en-US/fedora-server/administration/dnsmasq" target="_blank">[fedoraproject.org]</a>
> 

<br>

```text

docker run -it --rm --network host --name dnsmasq debian:bookworm

apt update -y
apt upgrade -y

apt install -y tzdata
apt install -y curl
#apt install -y xmlstarlet
#apt install -y uuid-runtime
apt install -y apt-transport-https 
apt install -y ca-certificates
apt install -y gnupg2 
apt install -y software-properties-common
apt install -y procps
apt install -y moreutils

apt install -y dnsmasq

# 
# Dnsmasq version 2.89  Copyright (c) 2000-2022 Simon Kelley
# Compile time options: IPv6 GNU-getopt DBus no-UBus i18n IDN2 DHCP DHCPv6 no-Lua TFTP conntrack ipset nftset auth cryptohash DNSSEC loop-detect inotify dumpfile
#


```