#!/bin/ash

set -e

if [ ! -z "${MOSQUITTO_USER}" ] && [ ! -z "${MOSQUITTO_PASS}" ]; then
    pwfile=/mosquitto/config/pwfile
    conf_file=/mosquitto/config/mosquitto.conf
    
    touch $pwfile
    chown mosquitto:mosquitto $pwfile
    mosquitto_passwd -b $pwfile ${MOSQUITTO_USER} ${MOSQUITTO_PASS}
    sed -i 's/\#allow_anonymous\ true/allow_anonymous\ false/' $conf_file
fi

exec "$@"

