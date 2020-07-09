#!/usr/bin/env bash

export version=3.1.19
docker build --tag testerum:$version --build-arg testerum_version=$version .
