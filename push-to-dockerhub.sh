#!/usr/bin/env bash

#
# Make sure you are logged-in to docker hub:
# docker login --username=yourhubusername --email=youremail@company.com
#

script_dir="$(dirname "${0}")"
source "${script_dir}/common.sh"

docker push docker.io/testerum/testerum:${testerum_version}
docker push docker.io/testerum/testerum:latest
