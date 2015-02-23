#!/bin/sh
set -e

. $(dirname $0)/common.sh

MIRRORS="$(list_mirrors)"

for mirror in ${MIRRORS}
do
    SNAPSHOT="${mirror}-$(date +%Y%m%d%H%M%S)"
    echo "I: Creating snapshot ${SNAPSHOT} from mirror ${mirror}..."
    ${APTLYCMD} snapshot create ${SNAPSHOT} from mirror ${mirror}
    snapshot_contents ${SNAPSHOT}
done
