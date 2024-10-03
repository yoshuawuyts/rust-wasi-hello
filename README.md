# Rust WASI Hello

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/yoshuawuyts/rust-wasi-hello)

An example project showing how to build an HTTP server for WASI 0.2 built in
Rust.

## Installation

The easiest way to try this project is by opening it in a GitHub Codespace. This
will create a VS Code instance with all dependencies installed. If instead you
would prefer to run this locally, you can run the following commands:

```bash
$ curl https://wasmtime.dev/install.sh -sSf | bash # install wasm runtime
$ cargo install cargo-component                    # install build tooling
$ cargo install wkg                                # install wasm OCI tooling
```

## Local Development

The HTTP server uses the `wasi:http/proxy` world. You can run it locally in a
`wasmtime` instance by using the following [cargo-component] command:

```rust
$ cargo component serve
```

## Working with deployment artifacts

This project automatically published compiled Wasm Components as OCI to GitHub
Artifacts. You can pull the artifact with any OCI-compliant tooling and run it
in any Wasm runtime that supports the `wasi:http/proxy` world. To fetch the
latest published version from GitHub releases and run it in a local `wasmtime`
instance you can run the following command:

```bash
$ wkg pull ghcr.io/yoshuawuyts/rust-wasi-hello:latest
$ wasmtime serve rust-wasi-hello.wasm
```

For production workloads however, you may want to use other runtimes or
integrations which provide their own OCI integrations. Deployment will vary
depending on you providers, though at their core they will tend to be variations
on the pull + serve pattern we've shown here.

## Roadmap

- [x] Get a base version compiling
- [x] Create a GitHub Actions Workflow
- [x] Add routes to the HTTP handler
- [ ] Create a wasm OCI publish action
- [ ] Setup a GitHub Codespace with all tools pre-installed
- [ ] Demo unit tests in CI
- [ ] Automatically publish a package on GitHub Release
- [ ] Add a load-testing example
- [ ] Upstream and integrate `scripts/` into their respective packages
- [ ] Add deploy remote artifact
- [ ] Show wkg pull and run locally

## License

MIT OR Apache-2.0

[cargo-component]: https://github.com/bytecodealliance/cargo-component
