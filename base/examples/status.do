#!/usr/bin/env bash
set -e

find . -name '*.rs' -print0 | xargs --null redo-ifchange

cargo test --examples &>"$3"
