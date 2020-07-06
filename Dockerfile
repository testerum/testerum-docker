FROM ubuntu:18.04

ARG testerum_version
ARG testerum_download_url=https://testerum.com/download/testerum-linux-${testerum_version}.tar.gz

ARG TESTERUM_ROOT_DIR=/opt/testerum_home
ENV TESTERUM_VERSION_FILE=$TESTERUM_ROOT_DIR/version

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000

# Testerum is run with user `testerum`, uid = 1000
# If you bind mount a volume from the host or a data container, ensure you use the same uid
RUN groupadd -g ${gid} ${group} \
    && useradd -d "$TESTERUM_ROOT_DIR" -u ${uid} -g ${gid} -m -s /bin/bash ${user}

RUN apt update
RUN mkdir -p $TESTERUM_ROOT_DIR

RUN echo "Install tools"
RUN apt -y install apt-utils
RUN apt -y install --no-install-recommends build-essential
RUN apt -y install wget
RUN apt -y install unzip
RUN apt -y install curl
RUN apt -y install gosu
RUN apt -y install bash

ENV DISPLAY=:99
ENV DISPLAY_CONFIGURATION=1024x768x24
RUN echo "Install Xvfb"
RUN apt -y install xvfb

RUN echo "Install fonts"
RUN apt -y install libfontconfig
RUN apt -y install libfreetype6
RUN apt -y install xfonts-cyrillic
RUN apt -y install xfonts-scalable
RUN apt -y install fonts-liberation
RUN apt -y install fonts-ipafont-gothic
RUN apt -y install fonts-wqy-zenhei
RUN apt -y install fonts-tlwg-loma-otf
RUN apt -y install ttf-ubuntu-font-family

RUN echo "Install Mozilla Firefox"
RUN apt -y install firefox
RUN firefox -version >> $TESTERUM_VERSION_FILE

RUN echo "Install Google Chrome"
ARG chrome_package='google-chrome-stable_current_amd64.deb'
RUN wget -O $chrome_package  https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i $chrome_package || apt -y -f install
RUN rm $chrome_package
RUN google-chrome --version >> $TESTERUM_VERSION_FILE

COPY ./src/wrap_chrome_binary.sh wrap_chrome_binary.sh
RUN chmod a+x wrap_chrome_binary.sh && ./wrap_chrome_binary.sh && rm -rfv ./wrap_chrome_binary.sh

WORKDIR $TESTERUM_ROOT_DIR

RUN curl -fsSL ${testerum_download_url} -o testerum.tar.gz \
    && mkdir -p testerum \
    && tar -xzf testerum.tar.gz -C testerum \
    && rm testerum.tar.gz;

WORKDIR $TESTERUM_ROOT_DIR/testerum

COPY docker/entrypoint.sh $TESTERUM_ROOT_DIR/testerum/

# RUN sed -i 's/-Dfile.encoding=UTF8/-Dfile.encoding=UTF8 -agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=8000/' ./runner/bin/testerum-runner.sh

RUN mkdir /reports/
RUN chown $uid:$gid /reports/

USER $uid:$gid

ENTRYPOINT ["/opt/testerum_home/testerum/entrypoint.sh"]
