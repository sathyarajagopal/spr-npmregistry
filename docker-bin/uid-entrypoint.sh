#!/bin/sh

if ! whoami &> /dev/null; then
  if [ -w /etc/passwd ]; then
    echo "${VERDACCIO_USER_NAME:-default}:x:$(id -u):0:${VERDACCIO_USER_NAME:-default} user:${HOME}:/sbin/nologin" >> /etc/passwd
  fi
fi

exec /usr/bin/dumb-init -- "$@"