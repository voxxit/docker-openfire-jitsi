FROM debian:jessie

ENV OPENFIRE_VERSION 3.10.0
ENV VIDEOBRIDGE_VERSION 446

RUN apt-get update \
 && apt-get install --no-install-recommends -y sudo wget openjdk-7-jre unzip\
 && wget --no-verbose "http://www.igniterealtime.org/downloadServlet?filename=openfire/openfire_${OPENFIRE_VERSION}_all.deb" \
      -O /tmp/openfire_${OPENFIRE_VERSION}_all.deb \
 && dpkg -i /tmp/openfire_${OPENFIRE_VERSION}_all.deb \
 && wget --no-verbose "https://download.jitsi.org/jitsi-videobridge/linux/jitsi-videobridge-linux-x64-${VIDEOBRIDGE_VERSION}.zip" \
      -O /tmp/videobridge.zip \
 && unzip /tmp/videobridge.zip -d /opt/ \
 && mv /opt/jitsi-videobridge-linux-x64-${VIDEOBRIDGE_VERSION} /opt/jitsi \ 
 && rm -rf /tmp/* \
 && apt-get purge --auto-remove -y wget unzip \
 && rm -rf /var/lib/apt/lists/*

COPY ofmeet.jar /usr/share/openfire/plugins/ofmeet.jar
COPY start /start

EXPOSE 3478-3479 5222-5223 5229 5275 7070 7443 7777 9090-9091 50000-60000

VOLUME [ "/data" ]

CMD [ "/start" ]

