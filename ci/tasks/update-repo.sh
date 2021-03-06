#!/bin/env bash
set -eu

echo "$TBS_KUBECONFIG" | base64 -d > ~/config
export KUBECONFIG=~/config

set -x
NEW_IMAGE=$(kubectl get image "$IMAGE_NAME" -o json | jq '.status.latestImage' -r)
PATTERN=$(echo "$NEW_IMAGE" | tr '@', "\n" | head -1)
CONTENT=$(sed "s|image: $PATTERN.*|image: $NEW_IMAGE|" cluster-repo/"$DEPLOYMENT_MANIFEST")
echo -n "$CONTENT" > cluster-repo/"$DEPLOYMENT_MANIFEST"

pushd cluster-repo || exit 1
git config user.email "concourse@59s.io"
git config user.name "concourse-ci"
git add .
git commit -m "Manifest updated by concourse pipeline."
popd || exit 1
