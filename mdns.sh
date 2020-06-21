#!/bin/sh

read -p "enter hostname:" hostname

pkg install mDNSResponder_nss

sysrc mdnsd_enable="YES"

touch /usr/local/etc/mdnsresponderposix.conf

echo $hostname >> /usr/local/etc/mdnsresponderposix.conf
echo "_http._tcp" >> /usr/local/etc/mdnsresponderposix.conf
echo "80" >> /usr/local/etc/mdnsresponderposix.conf

sed -i 's/hosts: files dns/hosts: files mdns dns/' /etc/nsswitch.conf

sysrc mdnsresponderposix_enable="YES"
sysrc mdnsresponderposix_flags="-f /usr/local/etc/mdnsresponderposix.conf"

service mdnsd restart
service mdnsresponderposix restart
service nsswitch restart
