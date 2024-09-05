# setup dir
mkdir -p tmp
cd tmp

# install wkg
git clone https://github.com/bytecodealliance/wasm-pkg-tools
cd wasm-pkg-tools/crates/wkg
cargo install --path .
cd ../../../../
