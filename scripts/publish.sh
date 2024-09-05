#!/bin/bash

# login to the registry
# if running locally, we may need to: 
# gh auth refresh -h github.com -s write:packages,read:packages
gh auth token | docker login ghcr.io --username YOURUSERNAME --password-stdin

# publish using wkg
PROJECT_NAME="rust_wasi_hello"
GH_USER=$(gh api user --jq '.login')
REGISTRY_REFERENCE="ghcr.io/${GH_USER}/rust-wasi-hello:latest"

wkg oci push $REGISTRY_REFERENCE target/wasm32-wasip1/release/$PROJECT_NAME.wasm
