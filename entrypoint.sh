#!/bin/sh
set -e

echo resolver $(awk 'BEGIN{ORS=" "} $1=="nameserver" {print $2}' /etc/resolv.conf) ";" > /etc/nginx/includes/resolver.conf

export DOLLAR='$'
envsubst < /etc/nginx/includes/location_root.conf.tpl > /etc/nginx/includes/location_root.conf
envsubst < /etc/nginx/includes/location_proxy.conf.tpl > /etc/nginx/includes/location_proxy.conf

exec "$@"
