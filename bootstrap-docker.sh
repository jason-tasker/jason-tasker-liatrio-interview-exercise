#!/bin/sh

REPOSITORY_NAME="tasker-liatrio-demo"
TAG="v1"
HOST_PORT="8080"
CONTAINER_PORT="8080"

echo "Building Container"
docker build -t $REPOSITORY_NAME:$TAG .

echo "Running container on http://127.0.0.1:$HOST_PORT"
docker run -p $HOST_PORT:$CONTAINER_PORT $REPOSITORY_NAME:$TAG
