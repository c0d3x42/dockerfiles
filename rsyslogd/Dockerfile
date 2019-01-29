FROM alpine:latest
RUN apk update && apk add rsyslog
COPY rsyslog.conf /usr/local/etc/rsyslog.conf
EXPOSE 514

ENTRYPOINT [ "rsyslogd", "-n", "-f", "/usr/local/etc/rsyslog.conf" ]