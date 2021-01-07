#!/usr/bin/env bash

script_dir="$(dirname "${0}")"
source "${script_dir}/common.sh"

docker run \
    --rm \
    -v /home/cvmocanu/temp/testerum/tests:/tests \
    -v /home/cvmocanu/temp/testerum/reports:/reports \
    --name testerum \
    "testerum/testerum:${testerum_version}"
