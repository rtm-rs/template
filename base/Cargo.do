#!/usr/bin/env bash
set -e

redo-ifchange Cargo.toml
cargo check
