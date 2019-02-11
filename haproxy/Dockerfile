FROM haproxy:1.9.4-alpine

COPY haproxy.conf /usr/local/etc/haproxy/haproxy.cfg
#VOLUME /haproxy
COPY http.503 rsyslog.map example-com.pem ca.crt /haproxy/