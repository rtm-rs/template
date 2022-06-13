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
- `RTM_TPL_PARENT_DIR`: The project parent directory.  Default: `$(pwd)`
- `RTM_TPL_PROJECT`: The name of the project.  Default: `mtr`
