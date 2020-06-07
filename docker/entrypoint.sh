#!/usr/bin/env bash

TESTERUM_DIR=/opt/testerum_home/testerum

exec "${TESTERUM_DIR}/runner/bin/testerum-runner.sh" \
    --repository-directory=/tests \
    --managed-reports-directory=/reports \
    --setting testerum.selenium.driver.headless=true

