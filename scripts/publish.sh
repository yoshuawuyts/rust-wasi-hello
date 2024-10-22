#!/bin/bash
tags="$1"
# not running in github actions? use gh cli to login, etc, locally
if [ "$GITHUB_ACTIONS" != "true" ]; then
    # login to the registry
    # if running locally, we may need to:
    # gh auth refresh -h github.com -s write:packages,read:packages
    gh auth token | docker login ghcr.io --username YOURUSERNAME --password-stdin
    GH_USER=$(gh api user --jq '.login')
    IMAGE_NAME="${GH_USER}/rust-wasi-hello"
fi

PROJECT_NAME="rust_wasi_hello"
REGISTRY_REFERENCE="ghcr.io/${IMAGE_NAME}:${tags}"

wkg oci push $REGISTRY_REFERENCE target/wasm32-wasip1/release/$PROJECT_NAME.wasm
