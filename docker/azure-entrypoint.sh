#!/usr/bin/env sh
set -e

export > /root/.profile

/usr/sbin/sshd

exec /bin/sh ./docker-entrypoint.sh "$@"