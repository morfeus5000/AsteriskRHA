FROM gliderlabs/alpine:edge

MAINTAINER Pablo Almeida Galvez <pablo.almeida.galvez@gmail.com>

VOLUME /var/log/asterisk
VOLUME /etc/asterisk
VOLUME /var/lib/asterisk

RUN apk add --update less curl sngrep ngrep \
      asterisk asterisk-curl asterisk-speex asterisk-sample-config \
&&  rm -rf /usr/lib/asterisk/modules/*pjsip* \
&&  rm -rf /var/cache/apk/* /tmp/* /var/tmp/*


#COPY var-asterisk.tar.gz /
#COPY etc-asterisk.tar.gz /

ADD etc-asterisk.tar.gz /etc-asterisk.tar.gz
ADD var-asterisk.tar.gz /var-asterisk.tar.gz

#RUN cd /tmp && \
#	tar -xzvf var-asterisk.tar.gz && tar -xzvf etc-asterisk.tar.gz && \
#	cp -rf /tmp/etc/asterisk /etc/asterisk && \
#	cp -rf /tmp/var/lib/asterisk/ /var/lib/asterisk/

EXPOSE 5060 5080 5066 7443 8021 5038 64535-65535

RUN asterisk && sleep 5

ADD docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod a+x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/asterisk", "-vvvdddf", "-T", "-W", "-U", "root", "-p"]