# Rust Type Mapper Templates

Simple & flexible:

- [Git clone particular files](https://stackoverflow.com/a/52269934/152860)
- [Gather user input for config file (see next item)](https://crates.io/crates/enquirer)
- [Shell (bash) templating](https://stackoverflow.com/a/48633756/152860)

RTM templates for: `cargo generate rtm-rs/template <name>`

## Usage

To setup a base CQRS-ES project with domains: `inventory`, `invoicing`,
`ordering` and `shipping`

```bash
cargo generate rtm-rs/template base-memory
for d in inventory invoicing ordering shipping;
do
  mkdir $d
  cd $d
  cargo generate --init rtm-rs/template domain
done
```
