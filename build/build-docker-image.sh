#!/bin/bash

CONTAINER_NAME="f1-grafana"

build_and_run() {
    docker build -t $CONTAINER_NAME .
    docker run -p 3000:3000 $CONTAINER_NAME
}
build_and_run