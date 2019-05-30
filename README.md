# loicmathieu/vsftpd
This is a docker container to launch vsftpd.
It comes with 4 pre-defined configuration :
- ftp : FTP
- ftps : FTPS explicit
- ftps_implicit : FTPS implicit
- ftps_tls : FTPS explicit with high cypher (ssl_ciphers=HIGH)

To use it : docker run -p <host_port>:21 loicmathieu/vsftpd <configuration_name>
```
docker pull loicmathieu/vsftpd
docker run -p 21:21 loicmathieu/vsftpd ftp
```

It comes with a pre-defined user : guest with password guest.

PASV is enabled, to use it you need to specify the PASV_ADDRESS env variable pointing to the IP address of the host when launching the container and mapping the ports range 21100-21110:
```
docker pull loicmathieu/vsftpd
docker run -p 21:21 -p21100-21110:21100-21110 --env PASV_ADDRESS=x.x.x.x loicmathieu/vsftpd ftp
```

For FTPS configurations, by default, PEM and PKCS-12 certificate keystore files are generated to `/etc/vsftpd/private`
location and are used by FTPS server. You can provide your own certificate keystore file, instead, by passing volume
to docker run command. For example, below command will have FTPS server use the provided certificate keystore PEM file
found at `/tmp/my_pem_file_dir` on the host machine. Make sure the file is named as `vsftpd.pem`.
```
docker run --volume "/tmp/my_pem_file_dir:/etc/vsftpd/private" loicmathieu/vsftpd ftps
```

Two volumes are defined :
- /home/guest : the FTP data directory of the guest user (the only available by default)
- /var/log/vsftpd : the log directory
