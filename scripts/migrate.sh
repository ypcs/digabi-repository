#!/bin/sh
set -e

. $(dirname $0)/common.sh

REPOSITORY="$1"
MIGRATION="$2"

case "${REPOSITORY}" in
    digabi)
    ;;
    digabi-custom)
    ;;
    *)
        echo "E: Invalid repository: ${REPOSITORY}!"
        exit 1
    ;;
esac

case "${MIGRATION}" in
    upstream-to-unstable)
        if [ "${REPOSITORY}" = "digabi-custom" ]
        then
            echo "E: There is not migration path ${MIGRATION} for ${REPOSITORY}."
            exit 1
        fi
        SOURCE="upstream"
        TARGET="unstable"
        CMD="import"
    ;;
    unstable-to-testing)
        SOURCE="unstable"
        TARGET="testing"
        CMD="copy"
    ;;
    testing-to-stable)
        # TODO: Require manuan confirmation?
        SOURCE="testing"
        TARGET="stable"
        CMD="copy"
    ;;
    *)
        echo "E: Invalid migration: ${MIGRATION}!"
        exit 1
    ;;
esac

for component in ${COMPONENTS}
do
    SOURCE_REPO="${REPOSITORY}-${SOURCE}-${component}"
    TARGET_REPO="${REPOSITORY}-${TARGET}-${component}"

    #PACKAGES_IN_TARGET="$(${APTLYCMD} repo show -with-packages=true ${TARGET_REPO} |grep '^  ' |cut -d_ -f1 |xargs)"
    PACKAGES_IN_TARGET="$(cat conf/packages.d/*.${TARGET} |xargs)"
    
    echo "I: Copying packages from ${SOURCE_REPO} to ${TARGET_REPO}: ${PACKAGES_IN_TARGET}"
    ${APTLYCMD} ${CMD} ${SOURCE_REPO} ${TARGET_REPO} ${PACKAGES_IN_TARGET}
    #PACKAGES_IN_TARGET="$(${APTLYCMD} )"
    # TODO: List packages in $TARGET_REPO, import these packages from $SOURCE_REPO to $TARGET_REPO
    
done
