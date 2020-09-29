#!/usr/bin/env bash

export version=3.2.1
docker build \
    --build-arg testerum_version=$version \
    --tag testerum/testerum:$version \
    --tag testerum/testerum:latest \
    .
