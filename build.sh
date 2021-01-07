#!/usr/bin/env bash

script_dir="$(dirname "${0}")"
source "${script_dir}/common.sh"

docker build \
    --build-arg testerum_version=${testerum_version} \
    --tag testerum/testerum:${testerum_version} \
    --tag testerum/testerum:latest \
    .
