FROM		centos:centos7 as builder
LABEL           maintainer="Jakub Scholz <www@scholzj.com>"

# Add qpidd group / user
RUN groupadd -r qpidd && useradd -r -d /var/lib/qpidd -m -g qpidd qpidd

# Install all dependencies
RUN curl -o /etc/yum.repos.d/qpid-proton-devel.repo http://repo.effectivemessaging.com/qpid-proton-devel.repo \
        && curl -o /etc/yum.repos.d/qpid-cpp-devel.repo http://repo.effectivemessaging.com/qpid-cpp-devel.repo \
        && curl -o /etc/yum.repos.d/qpid-python-devel.repo http://repo.effectivemessaging.com/qpid-python-devel.repo \
        && yum -y install epel-release \
        && yum -y --setopt=tsflag=nodocs --exclude=python2-qpid\* install openssl cyrus-sasl cyrus-sasl-md5 cyrus-sasl-plain qpid-cpp-server qpid-cpp-server-linearstore qpid-cpp-server-xml qpid-tools qpid-proton-c \
        && yum clean all

ENV QPIDD_VERSION DEVEL

RUN chown -R qpidd:qpidd /var/lib/qpidd
VOLUME /var/lib/qpidd

# Add entrypoint
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

RUN yum -y install git valgrind autoconf automake flex bison python-docutils python-sphinx json-c-devel \
                   libuuid-devel libgcrypt-devel zlib-devel openssl-devel libcurl-devel gnutls-devel \
                   mysql-devel postgresql-devel libdbi-dbd-mysql libdbi-devel net-snmp-devel \
                   libtool libestr-devel wget qpid-proton-c-devel 

RUN mkdir -p /tmp/build /app/rsyslog 


WORKDIR /tmp/build
RUN git clone https://github.com/rsyslog/rsyslog.git \
    && wget http://download.rsyslog.com/libfastjson/libfastjson-0.99.8.tar.gz \
    && tar -zxvf libfastjson-0.99.8.tar.gz \
    && cd /tmp/build/libfastjson-0.99.8 && ./configure --prefix=/app/rsyslog && make && make install

RUN yum -y install postgresql-libs postgresql-devel

ENV LIBFASTJSON_LIBS -L/app/rsyslog/lib -lfastjson
ENV LIBFASTJSON_CFLAGS -I /app/rsyslog/include/libfastjson
ENV PROTON_LIBS -lqpid-proton-core -lqpid-proton -lqpid-proton-proactor

RUN yum -y install libmaxminddb libmaxminddb-devel liblognorm liblognorm-devel
RUN yum -y install librabbitmq librabbitmq-devel
RUN yum -y install librelp librelp-devel

RUN cd /tmp/build/rsyslog && ./autogen.sh --prefix=/app/rsyslog \
    --enable-omamqp1 --enable-pgsql \
    --enable-omrabbitmq \
    --enable-debug --enable-diagtools --enable-usertools \
    --enable-impstats \
    --enable-imfile \
    --enable-imtcp \
    --enable-imptcp \
    --enable-inet \
#    --enable-relp \
    --enable-omfile \
    --enable-omhttp \
    --enable-omprog \
    --enable-omstdout \
    --enable-omruleset \
#    --enable-mmnormalize \
    --enable-mmjsonparse \
    --enable-mmcount \
    --enable-mmfields \
    --enable-mmpstrucdata \
    --enable-mmdblookup \
    && make && make install

FROM centos:centos7 as rsyslog
RUN curl -o /etc/yum.repos.d/qpid-proton-devel.repo http://repo.effectivemessaging.com/qpid-proton-devel.repo \
        && yum -y install epel-release \
        && yum -y --setopt=tsflag=nodocs --exclude=python2-qpid\* install qpid-proton-c \
          postgresql-libs libmaxminddb libestr \
        && yum clean all

COPY --from=builder /app /app
RUN yum -y install cyrus-sasl-plain cyrus-sasl-md5 librabbitmq
RUN yum -y install net-tools
RUN mkdir -p /app/rsyslog/etc/rsyslog.d /app/rsyslog/logs /app/rsyslog/spool
VOLUME /app/rsyslog/etc/rsyslog.d
VOLUME /app/rsyslog/logs

COPY rsyslog.conf /app/rsyslog/etc/rsyslog.conf
#COPY rsyslog-amqp.conf /etc/rsyslog/etc/rsyslog.d/amqp.conf
COPY docker-entrypoint-rsyslog.sh /docker-entrypoint.sh


# Expose port and run
EXPOSE 514
#CMD ["qpidd"]
ENTRYPOINT ["/docker-entrypoint.sh"]