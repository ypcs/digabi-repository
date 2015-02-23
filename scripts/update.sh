#!/bin/sh
set -e

. $(dirname $0)/common.sh

MIRRORS="$(list_mirrors)"

for mirror in ${MIRRORS}
do
    echo "I: Updating mirror ${mirror}..."
    update_mirror ${mirror}
    mirror_contents ${mirror}
done
