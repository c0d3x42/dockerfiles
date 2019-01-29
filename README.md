docker exec -ti dockerfiles_qpid_1 qpid-config -b admin/admin@localhost add queue rsyslogd  
 docker exec -ti dockerfiles_qpid_1 qpid-receive -b admin/admin@localhost -a rsyslogd --print-content yes -f
