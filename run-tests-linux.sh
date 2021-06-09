#!/usr/bin/env bash

script_dir="$(dirname "${0}")"
source "${script_dir}/common.sh"

docker run \
    --rm \
    --volume /home/cvmocanu/temp/testerum/tests/testerum-tests:/tests \
    --volume /home/cvmocanu/temp/testerum/reports:/reports \
    --name testerum \
    --user "$(id -u "${USER}"):$(id -g "${USER}")" \
    "testerum/testerum:${testerum_version}"
