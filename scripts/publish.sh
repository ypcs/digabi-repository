#!/bin/sh
set -e

. $(dirname $0)/common.sh

# TODO: Publish all repositories via HTTP

${APTLYCMD} publish snapshot -component=main,contrib,non-free digabi-custom-unstable-main digabi-custom-unstable-contrib digabi-custom-unstable-non-free debian

#${APTLYCMD} publish switch unstable upstream new-snapshot
