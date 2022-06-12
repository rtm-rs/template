# Template scripts

## Install

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

```bash
rtm-generate rtm/template base
# Default project name or the name you provided.
cd rtm-project
rtm-generate rtm/template base domain
```

## Development

```bash
makeself.sh --notemp rtm-generate rtm-generate.run "RTM Generator by NetworkMesh.io" echo "RTM Generator extracted"
```
