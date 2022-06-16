# Rust Type Mapper Templates

Simple & flexible:

- [Git clone particular files](https://stackoverflow.com/a/52269934/152860)
- [Gather user input for config file (see next item)](https://crates.io/crates/enquirer)
- [Shell (bash) templating](https://stackoverflow.com/a/48633756/152860)

RTM templates for: `cargo generate rtm-rs/template <name>`

## Install

Requirements:

- [`enquirer` (`cargo install enquirer`)](https://crates.io/crates/enquirer)
- [`git`](https://git-scm.com)
- [`sed](https://www.gnu.org/software/sed/)

```bash
curl --location \
     --remote-header-name \
     --remote-name \
     https://raw.githubusercontent.com/rtm/template/main/rtm-generate.run
chmod +x rtm-generate.run
./rtm-generator.run
install rtm-generate
rm rtm-generator.run
```

Alternatively, using wget

```bash
wget --no-check-certificate \
     --content-disposition \
     https://github.com/rtm/template/tarball/v0.7.1
     https://raw.githubusercontent.com/rtm/template/main/rtm-generator.run
chmod +x rtm-generate.run
./rtm-generator.run
install rtm-generate
rm rtm-generator.run
```

## Usage

To setup a base RTM project with domains: `inventory`, `invoicing`,
`ordering` and `shipping`

```bash
rtm-generate rtm/template base
# Default project name or the name you provided.
cd rtm-project
rtm-generate rtm/template base-domain
```

## Variables

If these environment variables are set the user will not be prompted to input
the related data.

- `RTM_TPL_AUTHORS`: The project authors. Default: `$USER`
- `RTM_TPL_CRATE_TYPE`: The crate type.  Default: `library`
- `RTM_TPL_LICENSES`: The project license(s).  Default: `apache2 mit`
- `RTM_TPL_PARENT_DIR`: The project parent directory.  Default: `$(pwd)`
- `RTM_TPL_PROJECT_NAME`: The name of the project.  Default: `mtr`
- `RTM_TPL_SOURCE`: The .  Default: ``
- `RTM_TPL_SQL_DB_HOST`: The .  Default: ``
- `RTM_TPL_SQL_DB_NAME`: The .  Default: ``
- `RTM_TPL_SQL_DB_PASSWORD`: The .  Default: ``
- `RTM_TPL_SQL_DB_PORT`: The .  Default: ``
- `RTM_TPL_SQL_DB_USER`: The .  Default: ``
- `RTM_TPL_SQL_MIGRATION`: The .  Default: ``
- `RTM_TPL_SQL_ORM`: The .  Default: ``
- `RTM_TPL_SQL_VENDOR`: The .  Default: ``
- `RTM_TPL_STORAGE_ADAPTERS`: The .  Default: ``
- `RTM_TPL_TLS`: The .  Default: ``

## Development

Initialize bare repository test fixture:

```bash
git --bare init fixtures/template.git
pushd fixtures/template.git
  git symbolic-ref HEAD refs/heads/main
  git config receive.denyCurrentBranch ignore
popd
```

Synchronize the local bare repo with the latest remote content - exclude the
commit history.

```bash
git clone fixtures/template.git /tmp/template
pushd /tmp/template
  git config user.email "begleybrothers@gmail.com"
  git config user.name "Begley Brothers Ltd"
  git remote add upstream https://github.com/rtm-rs/template.git
  git fetch --depth=1 upstream
  git reset --hard upstream/main
  git clean -dfx
  git remote remove upstream
  # Store the hash of the oldest commit (ie. in this case, the 50th) in a var
  START_COMMIT=$(git rev-list main|tail -n 1)
  # Checkout the oldest commit; detached HEAD
  git checkout $START_COMMIT
  # Create a new (temporary) orphaned branch.
  git checkout --orphan temp_branch
  # Initial commit of truncated history.
  git commit -m 'Template test fixtures updated'
  # Replay other commits on top of initial commit, in order, so rebase master
  # onto it, except for the oldest commit whose parents don't exist in the
  # shallow clone... it has been replaced by the 'Template test fixtures updated'
  # commit
  git rebase --onto temp_branch $START_COMMIT main
  # Push this to the new remote repo... don't push the temp branch, only master,
  # the beginning of whose commit chain will be our 'Template test fixtures
  # updated' commit
  git push -u origin main
popd
rm -rf /tmp/template
```
