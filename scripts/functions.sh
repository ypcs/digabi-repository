get_stagefile() {
    echo "${STAGEDIR}/$1"
}

set_stage() {
    SFILE="$(get_stagefile $1)"
    mkdir -p "$(dirname ${SFILE})"
    touch "${SFILE}"
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
    ${APTLYCMD} -keyring=${KEYRING} mirror create ${NAME} ${URL} ${SUITE} ${COMPONENT}
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
