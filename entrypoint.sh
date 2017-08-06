#!/bin/bash
set -e

WEBMIN_DATA=${DATA_DIR}/webmin
APACHE2_ETC=${DATA_DIR}/apache2
APACHE2_LOG=${DATA_DIR}/logs
APACHE2_WWW=${DATA_DIR}/www

mkdir -p ${DATA_DIR}

create_webmin_dir() {
  if [ ! -d ${WEBMIN_DATA} ]; then
    mkdir -p ${WEBMIN_DATA}
    cd /etc/webmin
    tar cf - . | (cd ${WEBMIN_DATA}; tar xf - )
  fi
  cd /
  rm -rf /etc/webmin
  ln -sf ${WEBMIN_DATA} /etc/webmin
}


create_apache_etc_dir() {
  if [ ! -d ${APACHE2_ETC} ]; then
    mkdir -p ${APACHE2_ETC}
    cd /etc/apache2
    tar cf - . | (cd ${APACHE2_ETC}; tar xf - )
  fi
  cd /
  rm -rf /etc/apache2
  ln -sf ${APACHE2_ETC} /etc/apache2
}

create_apache_log_dir() {
  if [ ! -d ${APACHE2_LOG} ]; then
    mkdir -p ${APACHE2_LOG}
    cd /var/log/apache2
    tar cf - . | (cd ${APACHE2_LOG}; tar xf - )
  fi
  cd /
  rm -rf /var/log/apache2
  ln -sf ${APACHE2_LOG} /var/log/apache2
}

create_apache_www_dir() {
  if [ ! -d ${APACHE2_WWW} ]; then
    mkdir -p ${APACHE2_WWW}
    cd /var/www/html
    tar cf - . | (cd ${APACHE2_WWW}; tar xf - )
  fi
  cd /
  rm -rf /var/www/html
  ln -sf ${APACHE2_WWW} /var/www/html
}



create_apache_etc_dir
create_apache_log_dir
create_apache_www_dir

/etc/init.d/rsyslog start
/etc/init.d/apache2 start

#/bin/bash

tail -f /var/log/apache2/access.log
