#!/usr/bin/env bash

source .env

podman build -t ${REGISTRY}/configsaver . 
podman push ${REGISTRY}/configsaver