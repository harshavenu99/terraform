#!/bin/bash

echo "${GITLAB_RUNNER_VERSION}" > /tmp/runner
echo "${GITLAB_SERVER_URL}" >> /tmp/runner
echo "${PROJECT_REGISTRATION_TOKEN}" >> /tmp/runner
