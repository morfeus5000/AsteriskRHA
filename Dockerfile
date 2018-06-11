FROM gliderlabs/alpine:edge

MAINTAINER Pablo Almeida Galvez <pablo.almeida.galvez@gmail.com>
RUN apk add --update less curl sngrep ngrep \
      asterisk asterisk-curl asterisk-speex asterisk-sample-config \
&&  rm -rf /usr/lib/asterisk/modules/*pjsip* \
&&  rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

VOLUME /var/log/asterisk
VOLUME /etc/asterisk
VOLUME /var/lib/asterisk

COPY var-asterisk.tar.gz /tmp
COPY etc-asterisk.tar.gz /tmp

RUN cd /tmp && \
	tar -xzvf var-asterisk.tar.gz && tar -xzvf etc-asterisk.tar.gz && \
	cp -arf /tmp/etc/asterisk /etc/asterisk && \
	cp -arf /tmp/var/lib/asterisk/ /var/lib/asterisk/

RUN asterisk && sleep 5

ADD docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod a+x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/asterisk", "-vvvdddf", "-T", "-W", "-U", "root", "-p"]