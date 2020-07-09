#!/usr/bin/env bash

export version=3.1.19
docker build \
    --tag testerum:$version \
    --tag testerum:latest \
    --build-arg testerum_version=$version \
    .
