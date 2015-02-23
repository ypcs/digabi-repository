#!/bin/sh
set -e

. $(dirname $0)/common.sh

MIRRORS="$(list_mirrors)"
REPOS="$(list_repos)"

for mirror in ${MIRRORS}
do
    SNAPSHOT="${mirror}-$(date +%Y%m%d%H%M%S)"
    echo "I: Creating snapshot ${SNAPSHOT} from mirror ${mirror}..."
    ${APTLYCMD} snapshot create ${SNAPSHOT} from mirror ${mirror}
    snapshot_contents ${SNAPSHOT}
done

for repo in ${REPOS}
do
    PACKAGES="$(${APTLYCMD} repo show ${repo} |grep '^Number of packages:' |cut -d: -f2)"
    if [ "${PACKAGES}" = "0" ]
    then
        echo "W: Skip snapshot creation for repository ${repo}, no packages..."
        continue
    fi
    SNAPSHOT="${repo}-$(date +%Y%m%d%H%M%S)"
    echo "I: Creating snapshot ${SNAPSHOT} from repository ${repo}..."
    ${APTLYCMD} snapshot create ${SNAPSHOT} from repo ${repo}
    snapshot_contents ${SNAPSHOT}
done
