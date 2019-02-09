FROM eclipse-mosquitto:1.5.5

ENV MOSQUITTO_AUTH_PLUG_VERSION=0.1.2 MOSQUITO_VERSION=1.5.5

WORKDIR /mosquitto
ADD config /mosquitto/config

#RUN echo "http://mirrors.aliyun.com/alpine/v3.4/main/" > /etc/apk/repositories && \
RUN apk update && \
    apk add wget mosquitto-dev postgresql-dev openssl build-base curl-dev libcurl sqlite-dev && \
    mkdir /mosquitto/src && \
    wget https://github.com/jpmens/mosquitto-auth-plug/archive/"$MOSQUITTO_AUTH_PLUG_VERSION".tar.gz \
        -O /mosquitto/src/mosquitto-auth-plug.tar.gz && \
    tar zxf /mosquitto/src/mosquitto-auth-plug.tar.gz -C /mosquitto/src && \
    mv /mosquitto/src/mosquitto-auth-plug-"$MOSQUITTO_AUTH_PLUG_VERSION" /mosquitto/src/mosquitto-auth-plug && \
    rm -rf /mosquitto/src/mosquitto_auth_plug.tar.gz && \
    mv /mosquitto/config/config.mk /mosquitto/src/mosquitto-auth-plug/config.mk && \
    cd /mosquitto/src/mosquitto-auth-plug && \
    make clean && make

#RUN mkdir /mosquitto/lib && \
#    install -s -m755 /mosquitto/src/mosquitto-auth-plug/auth-plug.so /mosquitto/lib/auth-plug.so

RUN mkdir /mosquitto/config.d

EXPOSE 1881 9001

