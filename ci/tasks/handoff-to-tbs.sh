#!/bin/bash
set -eu

echo "$TBS_KUBECONFIG" | base64 -d > ~/config
export KUBECONFIG=~/config
docker login -u "$REG_USER" -p "$REG_PASS" "$REG_URL"

set -x
kp image status "$IMAGE_NAME" > /dev/null 2>&1 || image=0
if [[ $image != 0 ]]; then
  kp image patch "$IMAGE_NAME" --local-path source -w
else
  kp image create "$IMAGE_NAME" --tag "$TAG" --local-path source -w
fi