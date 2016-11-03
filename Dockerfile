FROM debian:jessie
MAINTAINER Andras Istvan Nagy andras.istvan.nagy@gmail.com (forked from Alex Wilson a.wilson@alumni.warwick.ac.uk)

RUN apt-get update && apt-get install -q -y --no-install-recommends wget && apt-get install -q -y --no-install-recommends vim

RUN mkdir /opt/java
RUN wget --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" -qO- \
  http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101-linux-x64.tar.gz \
  | tar zxvf - -C /opt/java --strip 1

RUN mkdir /opt/flume
RUN wget -qO- http://archive.apache.org/dist/flume/1.7.0/apache-flume-1.7.0-bin.tar.gz \
  | tar zxvf - -C /opt/flume --strip 1

RUN mkdir /var/log/flume

ADD start-flume.sh /opt/flume/bin/start-flume

ENV JAVA_HOME /opt/java
ENV PATH /opt/flume/bin:/opt/java/bin:$PATH

CMD [ "/opt/flume/bin/start-flume" ]
