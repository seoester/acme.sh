#!/bin/sh

set -e

: "${LE_CONFIG_HOME:=/acme.sh}"
export LE_CONFIG_HOME="$LE_CONFIG_HOME"

case "$1" in
--version | --install | --uninstall | --upgrade | --issue | --signcsr | --deploy | --install-cert | --renew | --renew-all | --revoke | --remove | --list | --showcsr | --install-cronjob | --uninstall-cronjob | --cron | --toPkcs | --toPkcs8 | --update-account | --register-account | --create-account-key | --create-domain-key | --createCSR | --deactivate | --deactivate-account | --set-notify)
  exec /root/.acme.sh/acme.sh --config-home "$LE_CONFIG_HOME" "$@"
  ;;
daemon)
  exec crond -l 2 -f
  ;;
*)
  exec "$@"
  ;;
esac
