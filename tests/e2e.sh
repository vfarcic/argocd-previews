#!/usr/bin/env bash
set -o errexit

TEST_CHART=go-static-site

APP_ID=1 \
  REPO=atrakic/$TEST_CHART \
  IMAGE_TAG=v0.0.2 \
  HOSTNAME=pr-$(echo $RANDOM).$(curl -sSL ifconfig.co).xip.io \
  CHART_PATH=charts/$TEST_CHART \
  ./scripts/create.sh
