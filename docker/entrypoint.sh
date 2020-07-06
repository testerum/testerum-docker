#!/usr/bin/env bash

TESTERUM_DIR=/opt/testerum_home/testerum

if [ ! -d "/tests" ]; then
    echo "ERROR: please mount your tests directory at /tests"
    exit 1
fi

echo "Starting Testerum..."

exec "${TESTERUM_DIR}/runner/bin/testerum-runner.sh" \
    --repository-directory=/tests \
    --managed-reports-directory=/reports \
    --setting testerum.selenium.driver.headless=true

