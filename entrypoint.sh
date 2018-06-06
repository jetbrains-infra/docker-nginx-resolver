#!/bin/sh
set -e

echo resolver $(awk 'BEGIN{ORS=" "} $1=="nameserver" {print $2}' /etc/resolv.conf) ";" > /etc/nginx/resolver.conf

export DOLLAR='$'
envsubst < /etc/nginx/conf.d/default.conf.tpl > /etc/nginx/conf.d/default.conf

exec "$@"
