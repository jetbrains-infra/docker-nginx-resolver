FROM nginx:1.13-alpine

ENV backend_address localhost
ENV proxy_host_prefix readonly.

ADD entrypoint.sh /entrypoint.sh
ADD nginx /etc/nginx

CMD ["nginx", "-g", "daemon off;"]
ENTRYPOINT ["/entrypoint.sh"]
