#!/bin/sh

if [ "$1" = 'ftp' ]; then
 echo "Launching vsftp on ftp protocol"
 `/usr/sbin/vsftpd`
fi

if [ "$1" = 'ftps' ]; then
 echo "Launching vsftp on ftps protocol"
 `/usr/sbin/vsftpd /etc/vsftp/vsftp_ftps.conf`
fi

if [ "$1" = 'ftps_tls' ]; then
 echo "Launching vsftp on ftps with TLS only protocol"
 `/usr/sbin/vsftpd /etc/vsftp/vsftp_ftps_tls.conf`
fi
