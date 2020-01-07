#!/bin/bash

set -e

if [ -f /config/rsnapshot.conf ]; then
  echo "Using external configuration file..."
  cp /config/rsnapshot.conf /etc/rsnapshot.conf
else
  echo "Using default configuration file..."
fi

/usr/bin/rsnapshot "$@"