#!/bin/bash

# login to the registry
# if running locally, we may need to: 
# gh auth refresh -h github.com -s write:packages,read:packages
gh auth token | docker login ghcr.io --username YOURUSERNAME --password-stdin

# publish using wkg
PROJECT_NAME="rust_wasi_hello"

if [ -z "$IMAGE_NAME" ]; then
  GH_USER=$(gh api user --jq '.login')
  IMAGE_NAME="${GH_USER}/rust-wasi-hello"
  export IMAGE_NAME
fi

REGISTRY_REFERENCE="ghcr.io/${IMAGE_NAME}:latest"

wkg oci push $REGISTRY_REFERENCE target/wasm32-wasip1/release/$PROJECT_NAME.wasm
