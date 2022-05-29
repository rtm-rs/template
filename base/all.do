#!/usr/bin/env bash
set -e

## Redo if the *.do files change
#
# Only guard *.do file two levels down. Exclude self.
#
SELF=$(basename "${0##*/}" .do)
find . -maxdepth 2 -type f -name '*.do' -print0 | \
    xargs -0 echo | \
    sed -e 's/\.do//g' -e "s/\.\/$SELF//g" | \
    xargs redo-ifchange

# Find conflicts between here and our remote.
# Do the merge in memory - don't touch the index, nor the working tree.
git fetch origin main
if git merge-tree "$(git merge-base FETCH_HEAD main)" main FETCH_HEAD | grep -e '<<<<<<<' -e '>>>>>>>'
then
  echo "Merge conflict. May need manual intervention.  Exiting."
  exit 1
else
  # Looks OK.  Pull changes in for real.
  git pull --set-upstream origin main
fi
git push --set-upstream origin main
