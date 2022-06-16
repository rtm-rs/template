#!/usr/bin/env bash
set -e

find . -type f -name '*.toml' -print0 | xargs --null redo-ifchange

# Even if a *.rs file has changed (above), a redo script that monitors this,
# will see a change only if there has been a change across results.
# This prevents format changes, and the like, from triggering redo.
cat src/status | redo-stamp
