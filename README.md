# OpenWRT image builder
Docker image to automate building OpenWRT images. It is intended to be used with a `.config` file
with all desired settings preconfigured.

## Run

### Default run
```
docker run --rm -v /tmp/patches:/patches -v /tmp/output:/output -v /tmp/config:/config jbequinn/openwrt-builder
```
### Custom run
In case you need to do some extra operations before building images
```
docker run --rm -it -v /tmp/patches:/patches -v /tmp/output:/output -v /tmp/config:/config jbequinn/openwrt-builder /bin/bash
```
### Volumes
- `/patches`: any *.patch files mounted in this directory will be applied as git patches.
- `/config`: OpenWRT `.config` file will be copied from here. Otherwise, a default one will be generated.
- `/output`: compiled images will be copied to this directory.

### Environment variables
- `CPUS`: number of CPUs to use during compilation, or all available if not specified.
- `PATCHES`: Defaults to `/patches`. Directory to use for git patches.
- `CONFIG`: Defaults to `/config`. Directory where to look for the `.config` file.
- `OPENWRT_REPO`: Defaults to `/home/openwrt/openwrt`. OpenWRT repo directory to use for compiling images. The official OpenWRT repo (master branch) will be used if this directory does not exist.

## Build
```
docker build . --no-cache --pull --tag openwrt-builder
```
