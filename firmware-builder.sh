#!/bin/bash

if [ -z $OPENWRT_REPO ]; then
  echo "The OPENWRT_REPO is not set. Exiting"
  exit 1
fi

if [ ! -d "$OPENWRT_REPO" ]; then
  echo "Repository directory does not exist. Will clone official openwrt repo master branch"
  git clone https://github.com/openwrt/openwrt.git -b master "$OPENWRT_REPO"
fi

cd "$OPENWRT_REPO"

if [ -d "$PATCHES" ]; then
  echo "Applying patches"
  for patch in "$PATCHES/"*.patch; do
    echo "Processing $patch file..."
    git apply --verbose "$patch"
    if [ $? -ne 0 ]; then
      echo "Error when applying the patch. Exiting."
      exit 1
    fi
  done
fi

scripts/feeds update -a
scripts/feeds install -a

export TERM=xterm

if [ -d "$CONFIG" ]; then
  echo "Trying to copy '$CONFIG/.config'"
  if [ ! -f "$CONFIG/.config" ]; then
    # to avoid surprises after a long compilation, fail fast
    echo "Cannot find .config file"
    exit 1
  fi
  cp "$CONFIG/.config" "$OPENWRT_REPO/"
fi

make defconfig && make oldconfig

verbose_params=""
if [ "$VERBOSE" = "true" ]; then
  verbose_params="V=s"
fi
make -j${CPUS:-$(nproc)} $verbose_params toolchain/install; make -j${CPUS:-$(nproc)} $verbose_params

cp -r bin/targets/* /output
