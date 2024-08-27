#!/bin/bash

######################################################################################
######################################################################################

#
# ##################
# DNSMASQ ENTRYPOINT
# ##################
#

######################################################################################
######################################################################################

#
# REMOVE DEFAULT DNSMASQ CONFIGURATION
#

rm -rf /etc/dnsmasq.conf

#
# CONFIGURE USER & GROUP
#

echo "user=root" >>/etc/dnsmasq.conf
echo "group=root" >>/etc/dnsmasq.conf

#
# CONFIGURE DNS BIND PORT (UDP), IF SET [DFAULT IS 53/UDP]
#

if [ -n "$DNSMASQ_PORT" ]
then
  echo "port=$DNSMASQ_PORT" >>/etc/dnsmasq.conf
fi

#
# CONFIGURE SECURITY
#

echo "domain-needed" >>/etc/dnsmasq.conf
echo "bogus-priv" >>/etc/dnsmasq.conf
echo "filterwin2k" >>/etc/dnsmasq.conf

#
# TERMINATING CONTAINER IF ENVIRONMENT VARIABLE $DNSMASQ_UPSTREAM_SERVERS IS NOT FOUND OR EMPTY
#

if [ -z "$DNSMASQ_UPSTREAM_SERVERS" ]
then
  echo "Environment variable \$DNSMASQ_UPSTREAM_SERVERS not found!\nTerminating Container..."; exit 1
fi

#
# CONFIGURE DNS UPSTREAM SERVERS
#

echo "no-resolv" >>/etc/dnsmasq.conf

for i in ${DNSMASQ_UPSTREAM_SERVERS}
do
  echo "server=$i" >>/etc/dnsmasq.conf
done

#
# SWITCH TO THE MAIN PROCESS [CMD]
#

exec "$@"

######################################################################################
######################################################################################
