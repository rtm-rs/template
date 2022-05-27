# Rust Type Mapper Templates

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
