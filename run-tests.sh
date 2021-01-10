#!/usr/bin/env bash

script_dir="$(dirname "${0}")"
source "${script_dir}/common.sh"

export MSYS_NO_PATHCONV=1

docker run \
    -p8000:8000 \
    --rm \
    -v /c/temp/tutorial/tests:/tmp/project/tests \
    -v /c/temp/tutorial/reports:/tmp/project/reports \
    --name testerum \
    "testerum:${testerum_version}" \
    --setting BASE_URL=sadfdsf \
    --managed-reports-directory /tmp/project/reports \
    -e JAVA_OPTS=agent debug stuff

# docker run --rm -v /c/temp/tutorial/tests:/project/tests -v /c/temp/tutorial/reports:/project/reports --name testerum testerum:1.2 --output=CONSOLE
