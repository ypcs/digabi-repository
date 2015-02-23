#!/bin/sh
set -e
. $(dirname $0)/common.sh

# Import new package to *unstable*

# TODO: Support importing packages from mirrors
# TODO: Support importing packages from manual builds
# TODO: Support incoming -style folders
# TODO: Track from which origin package is from, and do not allow it to migrate from another sources
# TODO: Track components, import automatically to correct component

REPO="$1"
shift
PACKAGES="$@"
echo "D: List repositories..."
${APTLYCMD} repo list -raw

echo "I: Add package(s) to repository ${REPO}..."
${APTLYCMD} repo add ${REPO} ${PACKAGES}
