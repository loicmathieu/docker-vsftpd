#!/bin/sh

CONF_FILE = '/etc/vsftp/vsftp.conf'

if [ "$1" = 'ftp' ]; then
 echo "Launching vsftp on ftp protocol"
 CONF_FILE = '/etc/vsftp/vsftp.conf'
fi

if [ "$1" = 'ftps' ]; then
 echo "Launching vsftp on ftps protocol"
 CONF_FILE = '/etc/vsftp/vsftp_ftps.conf'
fi

if [ "$1" = 'ftps_implicit' ]; then
 echo "Launching vsftp on ftps protocol in implicit mode"
 CONF_FILE = '/etc/vsftp/vsftp_ftps_implicit.conf'
fi

if [ "$1" = 'ftps_tls' ]; then
 echo "Launching vsftp on ftps with TLS only protocol" 
 CONF_FILE = '/etc/vsftp/vsftp_ftps_tls.conf'
fi

if [ -n "$PASV_ADDRESS" ]; then
  echo "Activating passv on $PASV_ADDRESS"
  echo "pasv_address=$PASV_ADDRESS" >> $CONF_FILE
 fi
 
exec /usr/sbin/vsftpd $CONF_FILE

# forever loop just to prevent Docker container to exit, when run as daemon
while true; do sleep 1000; done
