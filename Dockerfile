# I really want to use alpine, but I can't get it to work for some reason, issues with Elastic not seeing the right jdk, and it's provisioning tool doesn't work. 
FROM debian:bookworm-slim

#trying to install the most minimal, I might not even have to include openjdk-17-headless because as I've stated before, elastic will provision the oracle openjdk-17
RUN apt update && apt install  -y --no-install-recommends openjdk-17-jre-headless
#--repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

#elasticsearch doesn't like being used as root
RUN useradd -ms /bin/bash elastic; su elastic

USER elastic

RUN mkdir -p /home/elastic/git/elasticsearch

#RUN git clone --progress --verbose https://github.com/elastic/elasticsearch.git git/elasticsearch - faster for me to just git in the local dir, then clone if multiple attempts to build Dockerfile
COPY --chown=elastic:elastic git/elasticsearch/ /home/elastic/git/elasticsearch/ 

RUN cd /home/elastic/git/elasticsearch && ./gradlew localDistro

# dirty code - sue me
RUN cp -R $(ls -dt /git/elasticsearch/build/distribution/local/elasticsearch-* | head -n 1)  /home/elastic/elasticsearch; cd /home/elastic/git/elasticsearch/build/local; PATH=$(ls)/bin:$PATH && export PATH; 


EXPOSE 9300 9200


#Doesn't run elastic on start
CMD elasticsearch
CMD sleep infinity


