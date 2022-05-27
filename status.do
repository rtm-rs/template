#!/usr/bin/env bash
set -e

readonly SUBREPO=template

find . -type f -name '*.rs' -print0 | xargs --null redo-ifchange
find . -type f -name '*.toml' -print0 | xargs --null redo-ifchange

pushd ./..
  git subrepo clean ${SUBREPO}
  git subrepo pull ${SUBREPO}
  # ingydotnet/git-subrepo/issues/530
  git subrepo push ${SUBREPO} --force
popd

# Even if a *.rs file has changed (above), a redo script that monitors this,
# will see a change only if there has been a change across results.
cat benches/status examples/status src/status tests/status | redo-stamp
