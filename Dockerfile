FROM debian:8

MAINTAINER Pablo Almeida Galvez <neocrow27@gmail.com>

# Get all asterisk prerequsites 
RUN apt-get update
RUN apt-get install -y build-essential openssl libxml2-dev libncurses5-dev uuid-dev sqlite3 libsqlite3-dev pkg-config curl libjansson-dev

# Download and decompress latest asterisk version
RUN curl -s http://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk-15.4.0.tar.gz | tar xz


# Asterisk compilation & installation
WORKDIR /asterisk-15.4.0
RUN ./configure; make; make install; make samples

CMD ["/usr/sbin/asterisk", "-vvvvvvv"]
 
