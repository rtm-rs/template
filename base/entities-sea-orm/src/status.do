#!/usr/bin/env bash
set -e

find . -type f -name '*.rs' -print0 | xargs --null redo-ifchange
