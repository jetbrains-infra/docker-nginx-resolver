FROM nginx:1.13-alpine

ENV backend_address localhost

ADD entrypoint.sh /entrypoint.sh
ADD nginx /etc/nginx

CMD ["nginx", "-g", "daemon off;"]
ENTRYPOINT ["/entrypoint.sh"]
