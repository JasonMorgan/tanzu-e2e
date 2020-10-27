#!/bin/bash

echo "$TBS_KUBECONFIG" | base64 -d > ~/config
export KUBECONFIG=~/config
kp image status "$IMAGE_NAME" > /dev/null 2>&1 || image=0
# if [[ $image != 0 ]]; then
#   kp image patch "$IMAGE_NAME" --local-path source/app.jar -w
# else
#   kp image create "$IMAGE_NAME" --tag "$CI_REGISTRY_IMAGE/$CI_COMMIT_BRANCH" --local-path source/app.jar -w
# fi

if [[ $image != 0 ]]; then
  kp image patch "$IMAGE_NAME" --local-path source -w
else
  kp image create "$IMAGE_NAME" --local-path source -w
fi