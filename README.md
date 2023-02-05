# OpenWRT image builder
Docker image to automate building OpenWRT images. It is intended to be used with a `.config` file
with all desired settings preconfigured.

## Run

### Default run
```
docker run --rm -e CPUS=5 -v /tmp/patches:/patches -v /tmp/output:/output -v /tmp/config:/config jbequinn/openwrt-builder
```
### Custom run
In case you need to do some extra operations before building images
```
docker run --rm -it -e CPUS=5 -v /tmp/patches:/patches -v /tmp/output:/output -v /tmp/config:/config jbequinn/openwrt-builder /bin/bash
```
### Environment variables
- `CPUS`: number of CPUs to use during compilation, or all available if not specified.

### Volumes
- `/patches`: any *.patch files mounted in this directory will be applied as git patches.
- `/config`: OpenWRT `.config` file will be copied from here. Otherwise, a default one will be generated.
- `/output`: compiled images will be copied to this directory.

## Build
```
docker build . --no-cache --pull --tag openwrt-builder
```
