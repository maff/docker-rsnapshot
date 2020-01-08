#!/bin/bash

set -eu

if [ "$(id docker -u)" != "${UID}" ]; then
  echo "INFO: Changing 'docker' UID to '${UID}'"
  usermod -o -u ${UID} docker
fi

if [ "$(id docker -g)" != "${GID}" ]; then
  echo "INFO: Changing 'docker' GID to '${GID}'"
  groupmod -o -g ${GID} docker
fi

if [ -f /config/rsnapshot.conf ]; then
  echo "INFO: Using external configuration file"
  cp /config/rsnapshot.conf /etc/rsnapshot.conf
else
  echo "INFO: Using default configuration file"
fi

gosu docker /usr/bin/rsnapshot "$@"
