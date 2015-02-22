#!/bin/sh
set -e

. $(dirname $0)/common.sh

MIRRORS="$(${APTLYCMD} mirror list -raw)"

for mirror in ${MIRRORS}
do
    echo "I: Updating mirror ${mirror}..."
    ${APTLYCMD} mirror update ${mirror}
done
