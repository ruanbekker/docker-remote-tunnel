FROM alpine

MAINTAINER Ruan Bekker <ruan@ruanbekekr.com>

ARG build_date
LABEL image.date=${build_date}

RUN apk --no-cache add screen docker openssl openssh-client apache2-utils
COPY docker-tunnel /usr/bin/docker-tunnel

RUN chmod +x /usr/bin/docker-tunnel

