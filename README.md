docker exec -ti dockerfiles_qpid_1 qpid-config -b admin/admin@localhost add queue rsyslogd  
docker exec -ti dockerfiles_qpid_1 qpid-receive -b admin/admin@localhost -a rsyslogd --print-content yes -f

# Build

`docker build -t c0d3x42/rsyslog-amqp rsyslog-qpid`
`docker build -t c0d3x42/rabbitmq rabbitmq`
`docker build -t c0d3x42/mqtt-auth mqtt-auth`

# Config

`docker-compose -f docker-compose.rabbitmq.yml exec rabbitmq rabbitmqctl set_log_level debug`

# Test

`docker-compose -f docker-compose.rabbitmq.yml exec rsyslog logger -p mail.info -T -n localhost -P 514 test1`
