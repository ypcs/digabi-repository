if [ -n "${DEBUG}" ]
then
    set -x
fi

APTLY="/usr/bin/aptly"
APTLY_FLAGS="-config=conf/aptly.conf"
APTLYCMD="${APTLY} ${APTLY_FLAGS}"

COMPONENTS="main contrib non-free"

SUITE="jessie"
DISTRIBUTIONS="unstable testing stable"

DEBIAN_MIRROR="http://http.debian.net/debian"

STAGEDIR="data/stage"

LOCAL_CONFIG="$(dirname 0)/../conf/local.sh"
if [ -r "${LOCAL_CONFIG}" ]
then
    . ${LOCAL_CONFIG}
fi

. $(dirname $0)/functions.sh
