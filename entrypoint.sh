#!/usr/bin/env bash

variables="HOSTNAME AWS_ZONEID AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY"

for var in ${variables}; do
  if [ -z ${var} ]; then
      echo "${var} environment variable is missing, please fix it!"
      exit 1
  fi
done

exec /usr/local/bin/ddns.sh

