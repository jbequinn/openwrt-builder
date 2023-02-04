# OpenWRT image builder

## Build
```
docker build . --no-cache --pull --tag openwrt-builder
```
## Run

### Default run
```
docker run --rm -e CPUS=5 -v /tmp/patches:/patches -v /tmp/output:/output -v /tmp/config:/config openwrt-builder
```
### Custom run
In case you need to do some extra operations before building images
```
docker run --rm -it -e CPUS=5 -v /tmp/patches:/patches -v /tmp/output:/output -v /tmp/config:/config openwrt-builder /bin/bash
```
