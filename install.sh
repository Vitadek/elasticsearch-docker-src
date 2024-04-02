#!/bin/bash

REPO_URL="https://github.com/elastic/elasticsearch"
REPO_DIR="git/elasticsearch"

mkdir -p $REPO_DIR

if [ -d $REPO_DIR/.git ]; then
    echo "Repo already cloned"
else
    echo "Repo not cloned. Cloning now..."
    git clone $REPO_URL $REPO_DIR
fi


sudo docker build --progress=plain -t elasticsearch_source:v1 -f Dockerfile .

