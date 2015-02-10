if [ -n "${DEBUG}" ]
then
    set -x
fi

APTLY="/usr/bin/aptly"
APTLY_FLAGS="-config=conf/aptly.conf"
APTLYCMD="${APTLY} ${APTLY_FLAGS}"

COMPONENTS="main contrib non-free"

SUITE="jessie"
STAGES="unstable testing stable"

DEBIAN_MIRROR="http://http.debian.net/debian"


. $(dirname $0)/functions.sh
