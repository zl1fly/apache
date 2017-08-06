FROM ubuntu

MAINTAINER info@uniq-it-4u.co.nz

ENV DATA_DIR=/data

WORKDIR /

#RUN apt-get -y update && apt-get -y upgrade && \
#    rm /var/lib/apt/lists/*lz4 && \
#    apt-get -o Acquire::GzipIndexes=false update && \
#    apt-get -y install wget perl libnet-ssleay-perl openssl libauthen-pam-perl \ 
#                       libpam-runtime libio-pty-perl python apt-show-versions && \
#    wget -q -O /webmin.deb http://www.webmin.com/download/deb/webmin-current.deb && \
#    dpkg -i /webmin.deb && \
#    rm /webmin.deb && \
#    apt-get -y install rsyslog 

RUN  apt-get -y update && apt-get -y upgrade && \
     apt-get -y install apache2 php imagemagick php-mysql libapache2-mod-php rsyslog php-bz2 php-zip
    
COPY entrypoint.sh /sbin/entrypoint.sh

RUN chmod 755 /sbin/entrypoint.sh

RUN echo "root:password" | chpasswd


EXPOSE 443/tcp
EXPOSE 80/tcp

ENTRYPOINT ["/sbin/entrypoint.sh"]
