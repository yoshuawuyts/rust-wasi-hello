#!/bin/bash

# setup dir
mkdir -p tmp
cd tmp

# install wkg
git clone https://github.com/bytecodealliance/wasm-pkg-tools
cd wasm-pkg-tools
cargo install --path .

# login to the registry
gh auth token | docker login ghcr.io --username yoshuawuyts --password-stdin

# publish using wkg
PROJECT_NAME="rust_wasi_hello"
REGISTRY_REFERENCE="ghcr.io/yoshuawuyts/rust-wasi-hello:latest"
wkg oci push $REGISTRY_REFERENCE target/wasm32-wasip1/release/$PROJECT_NAME.wasm
