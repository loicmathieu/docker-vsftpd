#!/bin/sh

CONF_FILE="/etc/vsftp/vsftp.conf"

if [ "$1" = "ftp" ]; then
 echo "Launching vsftp on ftp protocol"
fi

if [ "$1" = "ftps" ]; then
 echo "Launching vsftp on ftps protocol"
 CONF_FILE="/etc/vsftp/vsftp_ftps.conf"
fi

if [ "$1" = "ftps_implicit" ]; then
 echo "Launching vsftp on ftps protocol in implicit mode"
 CONF_FILE="/etc/vsftp/vsftp_ftps_implicit.conf"
fi

if [ "$1" = "ftps_tls" ]; then
 echo "Launching vsftp on ftps with TLS only protocol"
 CONF_FILE="/etc/vsftp/vsftp_ftps_tls.conf"
fi

if [ -n "$PASV_ADDRESS" ]; then
  echo "Activating passv on $PASV_ADDRESS"
  echo "pasv_address=$PASV_ADDRESS" >> $CONF_FILE
 fi

# If TLS flag is set and no certificate exists, generate it
if [ ! -e /etc/vsftpd/private/vsftpd.pem ] && [[ "$CONF_FILE" == *"ftps"* ]]
then
    echo "Generating self-signed certificate"
    mkdir -p /etc/vsftpd/private

    openssl req -x509 -nodes -days 7300 \
        -newkey rsa:2048 -keyout /etc/vsftpd/private/vsftpd.pem -out /etc/vsftpd/private/vsftpd.pem \
        -subj "/C=FR/O=My company/CN=example.org"
    openssl pkcs12 -export -out /etc/vsftpd/private/vsftpd.pkcs12 -in /etc/vsftpd/private/vsftpd.pem -passout pass:

    chmod 755 /etc/vsftpd/private/vsftpd.pem
    chmod 755 /etc/vsftpd/private/vsftpd.pkcs12
fi

&>/dev/null /usr/sbin/vsftpd $CONF_FILE
