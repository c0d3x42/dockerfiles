FROM alpine:3.8

RUN apk update && apk add gcc cmake pkgconfig
RUN apk add bash boost boost-dev libuuid git \
    g++ binutils make ruby ruby-dev doxygen valgrind \
    cyrus-sasl cyrus-sasl-dev cyrus-sasl-crammd5 cyrus-sasl-digestmd5

RUN mkdir /build
WORKDIR /build

RUN git clone https://github.com/apache/qpid-cpp.git


WORKDIR /build/qpid-cpp
RUN mkdir bld

WORKDIR /build/qpid-cpp/bld

RUN apk add util-linux-dev util-linux

RUN ln -s /usr/include/rpc/rpc.h /usr/include/rpc.h
RUN apk add swig

WORKDIR /build
RUN git clone https://github.com/apache/qpid-proton.git
WORKDIR /build/qpid-proton

RUN apk add openssl openssl-dev jsoncpp jsoncpp-dev python-dev

#RUN cmake ..

CMD ['/bin/bash']%            