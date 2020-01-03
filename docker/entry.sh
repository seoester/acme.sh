#!/bin/sh

set -e

export LE_CONFIG_HOME="${LE_CONFIG_HOME:=/acme.sh}"

if [ "${1:0:1}" = '-' ]; then
  set -- /root/.acme.sh/acme.sh --config-home "$LE_CONFIG_HOME" "$@"
fi

case "$1" in
daemon)
  set -- crond -l 2 -f
  ;;
esac

exec "$@"
