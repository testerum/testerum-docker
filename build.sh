#!/usr/bin/env bash

export version=5.0.2
docker build \
    --build-arg testerum_version=$version \
    --tag testerum/testerum:$version \
    --tag testerum/testerum:latest \
    .
