#!/usr/bin/env bash

bareos_fd_config="/etc/bareos/bareos-fd.d/director/bareos-dir.conf"

usermod -u ${PUID} bareos
usermod -aG ${PGID} bareos

if [ ! -f /etc/bareos/bareos-config.control ]; then
  tar xzf /bareos-fd.tgz --backup=simple --suffix=.before-control

  # Force client/file daemon password
  sed -i 's#Password = .*#Password = '\""${BAREOS_FD_PASSWORD}"\"'#' $bareos_fd_config

  # Control file
  touch /etc/bareos/bareos-config.control
fi

# Fix permissions
find /etc/bareos/bareos-fd.d ! -user bareos -exec chown bareos {} \;

# Run Dockerfile CMD
exec "$@"