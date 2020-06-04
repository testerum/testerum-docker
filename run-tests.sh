#!/usr/bin/env bash

export MSYS_NO_PATHCONV=1

docker run -p8000:8000 --rm -v /c/temp/tutorial/tests:/tmp/project/tests -v /c/temp/tutorial/reports:/tmp/project/reports --name testerum testerum:1.2 --setting BASE_URL=sadfdsf --repository-directory /tmp/project/tests --managed-reports-directory /tmp/project/reports -e JAVA_OPTS=agent debug stuff

# docker run --rm -v /c/temp/tutorial/tests:/project/tests -v /c/temp/tutorial/reports:/project/reports --name testerum testerum:1.2 --output=CONSOLE
