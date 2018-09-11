FROM nginx:1.13-alpine

LABEL maintainer="dmitry.shmelev@jetbrains.com"
LABEL image.Version="dev"

ARG CONTAINER_VERSION=dev

ENV CONTAINER_VERSION ${CONTAINER_VERSION}
ENV main_host localhost
ENV readonly_host false
ENV readonly_header_host readonly
ENV buildkotlinlang_host false
ENV buildkotlinlang_header_host false

ADD entrypoint.sh /entrypoint.sh
ADD nginx /etc/nginx

CMD ["nginx", "-g", "daemon off;"]
ENTRYPOINT ["/entrypoint.sh"]
