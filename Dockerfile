FROM alpine:latest

RUN apk build update && apk add --no-cache git curl

RUN mkdir -p git/elasticsearch 

RUN git clone --progress --verbose https://github.com/elastic/elasticsearch.git git/elasticsearch 

