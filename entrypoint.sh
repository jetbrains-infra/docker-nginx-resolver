#!/bin/sh
set -e
export DOLLAR='$'
for filename in /etc/nginx/includes/*.tpl; do
    envsubst < $filename > ${filename%.*}
done

echo resolver $(awk 'BEGIN{ORS=" "} $1=="nameserver" {print $2}' /etc/resolv.conf) ";" > /etc/nginx/includes/resolver.conf

exec "$@"
