FROM ubuntu:20.04

ARG testerum_version
ARG testerum_download_url=https://testerum.com/download/testerum-linux-${testerum_version}.tar.gz
ARG chrome_package='google-chrome-stable_current_amd64.deb'

ARG TESTERUM_ROOT_DIR=/opt/testerum_home

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000

ENV TESTERUM_VERSION_FILE=$TESTERUM_ROOT_DIR/version
ENV DISPLAY=:99
ENV DISPLAY_CONFIGURATION=1024x768x24

RUN \
    # Testerum is run with user `testerum`, uid = 1000
    # If you bind mount a volume from the host or a data container, ensure you use the same uid
    groupadd -g ${gid} ${group} \
    && useradd -d "$TESTERUM_ROOT_DIR" -u ${uid} -g ${gid} -m -s /bin/bash ${user} \
    && apt update \
    && mkdir -p $TESTERUM_ROOT_DIR \
    && echo "Install tools" \
    && apt -y install apt-utils \
    && apt -y install --no-install-recommends build-essential \
    && apt -y install wget \
    && apt -y install unzip \
    && apt -y install curl \
    && apt -y install gosu \
    && apt -y install bash \
    && echo "Install Xvfb" \
    && apt -y install xvfb \
    && echo "Install fonts" \
    && apt -y install libfontconfig \
    && apt -y install libfreetype6 \
    && apt -y install xfonts-cyrillic \
    && apt -y install xfonts-scalable \
    && apt -y install fonts-liberation \
    && apt -y install fonts-ipafont-gothic \
    && apt -y install fonts-wqy-zenhei \
    && apt -y install fonts-tlwg-loma-otf \
    && apt -y install ttf-ubuntu-font-family \
    && echo "Install Mozilla Firefox" \
    && apt -y install firefox \
    && firefox -version >> $TESTERUM_VERSION_FILE \
    && echo "Install Google Chrome" \
    && wget -O $chrome_package  https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && dpkg -i $chrome_package || apt -y -f install \
    && rm $chrome_package \
    && google-chrome --version >> $TESTERUM_VERSION_FILE

COPY ./src/wrap_chrome_binary.sh wrap_chrome_binary.sh
RUN chmod a+x wrap_chrome_binary.sh && ./wrap_chrome_binary.sh && rm -rfv ./wrap_chrome_binary.sh

RUN curl -fsSL ${testerum_download_url} -o $TESTERUM_ROOT_DIR/testerum.tar.gz \
    && mkdir -p $TESTERUM_ROOT_DIR/testerum \
    && tar -xzf $TESTERUM_ROOT_DIR/testerum.tar.gz -C $TESTERUM_ROOT_DIR/testerum \
    && rm $TESTERUM_ROOT_DIR/testerum.tar.gz

COPY docker/entrypoint.sh $TESTERUM_ROOT_DIR/testerum/

# RUN sed -i 's/-Dfile.encoding=UTF8/-Dfile.encoding=UTF8 -agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=8000/' ./runner/bin/testerum-runner.sh

RUN mkdir $TESTERUM_ROOT_DIR/testerum/reports/
RUN chown $uid:$gid $TESTERUM_ROOT_DIR/testerum/reports/

USER $uid:$gid

ENTRYPOINT ["/opt/testerum_home/testerum/entrypoint.sh"]
