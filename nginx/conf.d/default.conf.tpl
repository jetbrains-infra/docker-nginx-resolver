map ${DOLLAR}scheme ${DOLLAR}hsts_header {
    https   "max-age=31536000;";
}

map ${DOLLAR}http_upgrade ${DOLLAR}connection_upgrade {
    default upgrade;
    ''   '';
}

# Sets a $real_scheme variable whose value is the scheme passed by the load
# balancer in X-Forwarded-Proto (if any), defaulting to $scheme.
# Similar to how the HttpRealIp module treats X-Forwarded-For.
map ${DOLLAR}http_x_forwarded_proto ${DOLLAR}real_scheme {
  default ${DOLLAR}http_x_forwarded_proto;
  ''      ${DOLLAR}scheme;
}
map ${DOLLAR}http_x_forwarded_port ${DOLLAR}real_port {
  default ${DOLLAR}http_x_forwarded_port;
  ''      ${DOLLAR}server_port;
}

server {
        listen 80;

        if (${DOLLAR}http_x_forwarded_proto = "http") {
            return 301 https://${DOLLAR}host${DOLLAR}request_uri;
        }

        add_header Strict-Transport-Security ${DOLLAR}hsts_header;

        client_max_body_size 0;
        client_body_buffer_size 20m;
        proxy_buffering off;
        proxy_request_buffering off;

        error_log  /var/log/nginx/error.log  notice;
        access_log  /var/log/nginx/access.json.log  access_json;
        access_log /dev/stdout access_json;

        location / {
            include    /etc/nginx/resolver.conf;
            set        ${DOLLAR}backend "http://${backend_address}";
            proxy_pass ${DOLLAR}backend;

            proxy_intercept_errors on;
            proxy_read_timeout  1200;
            proxy_http_version  1.1;
            proxy_buffer_size   16k;
            proxy_buffers       128 16k;

            proxy_set_header    Host              ${DOLLAR}host;
            proxy_set_header    X-Real-IP         ${DOLLAR}remote_addr;
            proxy_set_header    X-Forwarded-For   ${DOLLAR}proxy_add_x_forwarded_for;
            proxy_set_header    X-Forwarded-By    ${DOLLAR}server_addr:$server_port;
            proxy_set_header    X-Forwarded-Proto ${DOLLAR}real_scheme;
            proxy_set_header    X-Forwarded-Host  ${DOLLAR}host:${DOLLAR}real_port;
            proxy_set_header    X-Forwarded-Port  ${DOLLAR}real_port;
            proxy_set_header    Upgrade           ${DOLLAR}http_upgrade;
            proxy_set_header    Connection        ${DOLLAR}connection_upgrade;
        }

        error_page 500 502 503 504  /maintenance.html;

        location = /maintenance.html {
            root  /etc/nginx/conf.d;
            expires -1;
            allow all;
        }

        location = /test503 {
          return 503;
        }

        location /health_check {
            return 200;
        }

        error_page 404 /404.html;
        location = /404.html {
            root   /usr/share/nginx/html;
            index  index.html index.htm;
            expires -1;
        }
}
