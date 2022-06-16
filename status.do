#!/usr/bin/env bash
set -e

function _redo_stamp () {
  # Even if a *.rs file has changed (above), a redo script that monitors this,
  # will see a change only if there has been a change across results.
  cat benches/status examples/status src/status tests/status | redo-stamp
}

readonly SUBREPO=template

find . -type f -name '*.rs' -print0 | xargs --null redo-ifchange
find . -type f -name '*.toml' -print0 | xargs --null redo-ifchange

# # The remote commit hash we have in the subrepo.
# subrepo_commit="$(echo $(git log|grep merged|head -n 1|cut -d : -f 2))"
# subrepo_commit="$(echo ${subrepo_commit//\"})"

## Sync template test fixture with latest remote
#
# Work in a temporary folder in case things go sideways.
#
# bare_repo=$(mktemp --directory)
# clone_repo=$(mktemp --directory)
# git init --bare --initial-branch=main ${bare_repo}.git
# git clone file://${bare_repo}.git ${clone_repo}
# pushd ${clone_repo}
#   git config advice.setUpstreamFailure false
#   git config advice.detachedHead false
#   git config user.email "begleybrothers@gmail.com"
#   git config user.name "Begley Brothers Inc"
#   git remote add upstream https://github.com/rtm-rs/template.git
#   git fetch --depth=1 upstream
#   git reset --hard upstream/main
#   git clean -dfx
#   git remote remove upstream
#   # Store the hash of the oldest commit (ie. in this case, the 50th) in a var
#   start_commit=$(git rev-list main|tail -n 1)
#   # Test if already uptodate
#   if [[ "${start_commit:1:7}" == "${subrepo_commit}" ]]
#   then
#     popd
#     _redo_stamp
#     exit 0
#   fi
#   # Checkout the oldest commit; detached HEAD
#   git checkout $start_commit
#   # Create a (temporary) orphaned branch.
#   git checkout --orphan temp_branch
#   # Initial commit of truncated history.
#   git add .
#   git commit -a -m 'Template test fixture updated' || true
#   # Replay commits on top of initial commit.
#   git rebase --onto temp_branch $start_commit main
#   # Push main to the new bare repo...
#   git push -u origin main
# popd
# rm -rf ${clone_repo}

## Swap out the new for old
#
# rm -rf test/fixtures/template.git
# mv ${bare_repo}.git test/fixtures/template.git
# git add .
# git commit -a -m 'Template test fixture updated' || true

pushd ./..
  git subrepo clean ${SUBREPO}
  git subrepo pull ${SUBREPO}
  # ingydotnet/git-subrepo/issues/530
  git subrepo push ${SUBREPO} --force
popd

_redo_stamp
