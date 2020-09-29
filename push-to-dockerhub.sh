#!/usr/bin/env bash

#
# Make sure you are logged-in to docker hub:
# docker login --username=yourhubusername --email=youremail@company.com
#

export version=3.2.1
docker push docker.io/testerum/testerum:${version}
docker push docker.io/testerum/testerum:latest
