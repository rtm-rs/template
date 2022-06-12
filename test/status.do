#!/usr/bin/env bash

redo-ifchange test.bats

# pushd ./../
./bats/bin/bats test.bats
# popd