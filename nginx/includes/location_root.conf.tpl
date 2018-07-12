include    /etc/nginx/includes/resolver.conf;
set        ${DOLLAR}backend "http://${backend_address}";
proxy_pass ${DOLLAR}backend;

proxy_intercept_errors on;
proxy_read_timeout  1200;
proxy_http_version  1.1;
proxy_buffer_size   16k;
proxy_buffers       128 16k;

proxy_set_header    Host              ${DOLLAR}proxy_header_host;
proxy_set_header    X-Real-IP         ${DOLLAR}remote_addr;
proxy_set_header    X-Forwarded-For   ${DOLLAR}proxy_add_x_forwarded_for;
proxy_set_header    X-Forwarded-By    ${DOLLAR}server_addr:$real_port;
proxy_set_header    X-Forwarded-Proto ${DOLLAR}real_scheme;
proxy_set_header    X-Forwarded-Host  ${DOLLAR}real_host;
proxy_set_header    X-Forwarded-Port  ${DOLLAR}real_port;
proxy_set_header    Upgrade           ${DOLLAR}http_upgrade;
proxy_set_header    Connection        ${DOLLAR}connection_upgrade;
