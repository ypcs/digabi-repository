add_mirror() {
    NAME="$1"
    SUITE="$2"
    URL="$3"
    KEYRING="$4"
    COMPONENT="$5"
    ${APTLYCMD} -keyring=${KEYRING} mirror create ${NAME} ${URL} ${SUITE} ${COMPONENT}
}

add_repository() {
    NAME="$1"
    ${APTLYCMD} repo create ${NAME}
}
