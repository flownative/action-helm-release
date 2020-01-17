#!/bin/bash
set -ex

export INPUT_CHARTS_FOLDER=${INPUT_CHARTS_FOLDER:-.}

if [ -z "${INPUT_CHART_NAME}" ]; then
  echo "chart_name is not set"
  exit 1
fi

if [ -z "${INPUT_REPOSITORY_URL}" ]; then
  echo "repository_url is not set"
  exit 1
fi

if [ -z "${INPUT_REPOSITORY_USER}" ]; then
  echo "repository_user is not set"
  exit 1
fi

if [ -z "${INPUT_REPOSITORY_PASSWORD}" ]; then
  echo "repository_password is not set"
  exit 1
fi

cd "${INPUT_CHARTS_FOLDER}/${INPUT_CHART_NAME}"

helm inspect chart .
helm package .
helm push "${INPUT_CHART_NAME}"-* "${INPUT_REPOSITORY_URL}" --username "${INPUT_REPOSITORY_USER}" --password "${INPUT_REPOSITORY_PASSWORD}" --force
