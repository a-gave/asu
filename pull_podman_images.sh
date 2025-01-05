#!/bin/bash

OPENWRT_VERSION=${OPENWRT_VERSION:-23.05.5}
BASE_CONTAINER=${BASE_CONTAINER:-ghcr.io/openwrt/imagebuilder}

targets=($(curl -s "https://downloads.openwrt.org/releases/${OPENWRT_VERSION}/.targets.json" | sed 's|.*\"\(.*\)\"\:.*|\1|g' | tail -n +2 | head -n -1 | sort | sed 's|/|-|g'))

for i in ${!targets[@]}; do 
  echo "$i/${#targets[@]} - Pulling ${targets[$i]} "
  
  IMAGE="${BASE_CONTAINER}:${targets[$i]}-v${OPENWRT_VERSION}"
  podman pull $IMAGE > /dev/null 2>&1
done
