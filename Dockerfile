FROM centos

RUN yum -y install openssl vsftpd && rm -rf /var/cache/yum/*

RUN openssl req -x509 -nodes -days 7300\
            -newkey rsa:2048 -keyout /etc/vsftpd/vsftpd.pem -out /etc/vsftpd/vsftpd.pem\
            -subj "/C=FR/O=My company/CN=example.org"

RUN useradd -ms /bin/bash guest && echo 'guest:guest' | chpasswd

COPY vsftp.conf /etc/vsftp/vsftp.conf
COPY vsftp_ftps.conf /etc/vsftp/vsftp_ftps.conf
COPY vsftp_ftps_tls.conf /etc/vsftp/vsftp_ftps_tls.conf
COPY vsftp_ftps_implicit.conf /etc/vdsftp/vsftp_ftps_implicit.conf
COPY start.sh /

RUN chmod +x /start.sh
RUN mkdir -p /home/vsftpd/
RUN chown -R ftp:ftp /home/vsftpd/
RUN chown ftp:ftp /etc/vsftpd/vsftpd.pem

VOLUME /home/vsftpd
VOLUME /var/log/vsftpd

EXPOSE 21

ENTRYPOINT ["/start.sh"]
CMD "ftp"
