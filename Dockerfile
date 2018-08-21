FROM nginx:1.13-alpine

LABEL maintainer="dmitry.shmelev@jetbrains.com"
LABEL image.Version="dev"

ARG CONTAINER_VERSION=dev

ENV CONTAINER_VERSION ${CONTAINER_VERSION}
ENV backend_address localhost
ENV readonly_host_prefix readonly.

ADD entrypoint.sh /entrypoint.sh
ADD nginx /etc/nginx

CMD ["nginx", "-g", "daemon off;"]
ENTRYPOINT ["/entrypoint.sh"]
