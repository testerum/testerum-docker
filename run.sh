#!/usr/bin/env bash

export version=3.2.1
docker run --rm -v /home/cvmocanu/temp/tests:/tests -v /home/cvmocanu/temp/reports:/reports --name testerum testerum/testerum:$version

