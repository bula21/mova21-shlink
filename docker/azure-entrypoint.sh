#!/usr/bin/env sh
set -e

env > /root/.profile
echo "export DEFAULT_DOMAIN DB_DRIVER DB_HOST DB_NAME DB_USER DB_PASSWORD DB_PORT IS_HTTPS_ENABLED" >> /root/.profile

/usr/sbin/sshd

exec /bin/sh ./docker-entrypoint.sh "$@"