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

## Sync template test fixture with latest remote
#
# Work in a temporary folder in case things go sideways.
#
bare_repo=$(mktemp --directory)
clone_repo=$(mktemp --directory)
git init --bare ${bare_repo}.git
git clone -b main file://${bare_repo}.git ${clone_repo}
pushd ${clone_repo}
  git config advice.setUpstreamFailure false
  git config user.email "begleybrothers@gmail.com"
  git config user.name "Begley Brothers Inc"
  git remote add upstream https://github.com/rtm-rs/template.git
  git fetch --depth=1 upstream
  git reset --hard upstream/main
  git clean -dfx
  git remote remove upstream
  git branch -m master main
  # Store the hash of the oldest commit (ie. in this case, the 50th) in a var
  start_commit=$(git rev-list main|tail -n 1)
  # Checkout the oldest commit; detached HEAD
  git checkout $start_commit
  # Create a (temporary) orphaned branch.
  git checkout --orphan temp_branch
  # Initial commit of truncated history.
  git commit -m 'Template test fixture updated'
  # Replay commits on top of initial commit.
  git rebase --onto temp_branch $start_commit main
  # Push main to the new bare repo...
  git push -u origin main
popd
rm -rf ${clone_repo}

## Swap out the new for old
#
rm -rf test/fixtures/template.git
mv ${bare_repo}.git test/fixtures/template.git

# Even if a *.rs file has changed (above), a redo script that monitors this,
# will see a change only if there has been a change across results.
cat benches/status examples/status src/status tests/status | redo-stamp
