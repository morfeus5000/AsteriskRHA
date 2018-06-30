FROM centos:centos7
MAINTAINER Pablo Almeida Galvez "pablo.almeida.galvez@gmail.com" 
RUN yum -y clean all && yum -y update && yum -y install epel-release && yum -y install wget vim tar htop gcc-c++ make gnutls-devel kernel-devel libxml2-devel ncurses-devel subversion doxygen texinfo curl-devel net-snmp-devel neon-devel uuid-devel libuuid-devel sqlite-devel sqlite git speex-devel gsm-devel libtool && ldconfig

WORKDIR /usr/src
RUN wget http://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk-15.4.0.tar.gz && tar -zxvf asterisk-15.4.0.tar.gz

WORKDIR /usr/src/asterisk-15.4.0/contrib/scripts
RUN ./install_prereq install && ./install_prereq install-unpackaged && ./get_mp3_source.sh

WORKDIR /usr/src/asterisk-15.4.0
RUN ./configure CFLAGS='-g -O2' --libdir=/usr/lib64 && make && make install && make samples && yum -y clean all

EXPOSE 5060 5080 5066 7443 8021 5038 10000 10001 10002 10003 10004 10005 10006 10007

WORKDIR /root
CMD ["/usr/sbin/asterisk", "-vvvvvvv"]


