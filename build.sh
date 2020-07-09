#!/usr/bin/env bash

export version=3.1.20
docker build \
    --build-arg testerum_version=$version \
    --tag testerum/testerum:$version \
    --tag testerum/testerum:latest \
    .
