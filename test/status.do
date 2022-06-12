#!/usr/bin/env bash

find . -maxdepth 1 -type f -name '*.bats' -print0 | xargs --null redo-ifchange

find . -maxdepth 1 -type f -name '*.bats' -print0 | xargs --null ./bats/bin/bats
