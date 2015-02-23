get_stagefile() {
    echo "${STAGEDIR}/$1"
}

set_stage() {
    SFILE="$(get_stagefile $1)"
    mkdir -p "$(dirname ${SFILE})"
    touch "${SFILE}"
}

remove_stage() {
    SFILE="$(get_stagefile $1)"
    rm -f "${SFILE}"
}

stage() {
    SFILE="$(get_stagefile $1)"
    if [ -e "${SFILE}" ]
    then
        echo "1"
    else
        echo "0"
    fi
}

add_mirror() {
    NAME="$1"
    if [ "$(stage add-mirror-${NAME})" = "1" ]
    then
        return
    fi
    SUITE="$2"
    URL="$3"
    KEYRING="$4"
    COMPONENT="$5"
    NOSOURCES="$6"
    if [ "${NOSOURCES}" = "nosources" ]
    then
        ARGS="-with-sources=false"
    else
        ARGS=""
    fi
    ${APTLYCMD} -keyring=${KEYRING} ${ARGS} mirror create ${NAME} ${URL} ${SUITE} ${COMPONENT}
    set_stage "add-mirror-${NAME}"
}

add_repository() {
    NAME="$1"
    if [ "$(stage add-repository-${NAME})" = "1" ]
    then
        return
    fi
    ${APTLYCMD} repo create ${NAME}
    set_stage "add-repository-${NAME}"
}

add_keyring() {
    FILE="$1"
    if [ ! -f "${FILE}" ]
    then
        echo "E: File not found: ${FILE}!" 1>&2
        exit 1
    fi
    HASH="$(echo ${FILE} |md5sum)"
    if [ "$(stage add-keyring-${HASH})" = "1" ]
    then
        return
    fi
    gpg --keyring=${KEYRING} --no-default-keyring --import ${FILE}
    set_stage "add-keyring-${HASH}"
}

list_mirrors() {
    ${APTLYCMD} mirror list -raw
}

update_mirror() {
    MIRROR="$1"
    ${APTLYCMD} -keyring=${KEYRING} mirror update ${MIRROR}
}

repository_contents() {
    REPO="$1"
    IS_MIRROR="$2"
    if [ -n "${IS_MIRROR}" ]
    then
        CMD="mirror"
    else
        CMD="repo"
    fi
    ${APTLYCMD} ${CMD} show -with-packages=true ${REPO} |tee contents_${CMD}_${REPO}.${BUILD_TAG:-$(date +%Y%m%d%H%M%S)}.list
}

mirror_contents() {
    repository_contents $1 ismirror
}
