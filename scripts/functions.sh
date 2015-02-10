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
