#!/usr/bin/env bash
set -euo pipefail

APP_ID="${APP_ID:?Error: APP_ID must be set}"

_APP_ID=$(echo $APP_ID | sed -e 's#/#-#g')

rm -rf charts/previews/templates/"$_APP_ID".yaml
