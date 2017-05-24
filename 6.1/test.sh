#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

name=$1
image=$2

cid="$(docker run -d --name "${name}" "${image}")"
trap "docker rm -vf $cid > /dev/null" EXIT

confluence() {
	docker run --rm -i --link "${name}":"confluence" "${image}" "${@}"
}

confluence make check-ready wait_seconds=5 max_try=12 delay_seconds=5 host="confluence"
