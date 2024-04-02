# I really want to use alpine, but I can't get it to work for some reason, issues with Elastic not seeing the right jdk, and it's provisioning tool doesn't work. 
FROM debian:bookworm-slim

#trying to install the most minimal, I might not even have to include openjdk-17-headless because as I've stated before, elastic will provision the oracle openjdk-17
RUN apt update && apt install  -y openjdk-17-jre-headless
#--repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

RUN mkdir -p git/elasticsearch 

#RUN git clone --progress --verbose https://github.com/elastic/elasticsearch.git git/elasticsearch - faster for me to just git in the local dir, then clone if multiple attempts to build Dockerfile
COPY git/elasticsearch git/elasticsearch

#ENV JAVA_HOME /usr/lib/jvm/openjdk-21

RUN cd git/elasticsearch && ./gradlew localDistro 
CMD /bin/sh -c 'sleep infinity'

