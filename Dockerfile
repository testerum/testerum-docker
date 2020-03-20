FROM debian:stretch-slim

#RUN apk add --no-cache curl bash
RUN apt-get update && apt-get install -y curl

ARG user=testerum
ARG group=testerum
ARG uid=1000
ARG gid=1000
ARG http_port=9999
ARG testerum_version
ARG testerum_download_url=https://testerum.com/download/testerum-linux-${testerum_version}.tar.gz

ENV TESTERUM_HOME /var/testerum_home

# Testerum is run with user `testerum`, uid = 1000
# If you bind mount a volume from the host or a data container,ensure you use the same uid
#RUN addgroup -g ${gid} ${group} \
#    && adduser -h "$TESTERUM_HOME" -u ${uid} -G ${group} -s /bin/bash -D ${user}

WORKDIR /usr/share

RUN curl -fsSL ${testerum_download_url} -o testerum.tar.gz \
    && mkdir -p testerum \
    && tar -xzf testerum.tar.gz -C testerum \
    && rm testerum.tar.gz;

# for main web interface:
EXPOSE ${http_port}

WORKDIR /usr/share/testerum

ENTRYPOINT ["./start.sh"]
