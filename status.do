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

# Sync template test fixture with latest remote
rm -rf test/fixtures/template.git
git init --bare test/fixtures/template.git
pushd test/fixtures/template.git
  git fetch --depth=1 https://github.com/rtm-rs/template.git
popd
git add .
git commit -m "Evolve[Test]: Synchronize template test fixture"

# Even if a *.rs file has changed (above), a redo script that monitors this,
# will see a change only if there has been a change across results.
cat benches/status examples/status src/status tests/status | redo-stamp
