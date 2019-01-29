#!/bin/bash
set -e

RSYSLOG_BINARY=/app/rsyslog/sbin/rsyslogd

# if command starts with an option, prepend qpidd
if [ "${1:0:1}" = '-' ]; then
    set -- $RSYSLOG_BINARY "$@"
fi


if [ "$1" = "$RSYSLOG_BINARY" ]; then
  $RSYSLOG_BINARY -dnf /app/rsyslog/etc/rsyslog.conf
  set -- "$@"
fi

exec "$@"
