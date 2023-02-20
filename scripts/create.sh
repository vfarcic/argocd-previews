#!/usr/bin/env bash
set -euo pipefail

APP_ID="${APP_ID:?Error: APP_ID must be set}"
REPO="${REPO:?Error: REPO must be set}"
IMAGE_TAG="${IMAGE_TAG:?Error: IMAGE_TAG must be set}"
HOSTNAME="${HOSTNAME:?Error: HOSTNAME must be set}"
CHART_PATH="${CHART_PATH:?Error: CHART_PATH must be set}"

_APP_ID=$(echo $APP_ID | sed -e 's#/#-#g')

cat preview.yaml | \
  kyml tmpl -e HOSTNAME -e APP_ID -e IMAGE_TAG -e REPO -e CHART_PATH\
  | tee charts/previews/templates/"$_APP_ID".yaml
