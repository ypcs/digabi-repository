#!/bin/sh
set -e

. $(dirname $0)/common.sh

# TODO: Create GPG keyring
# TODO: Use our custom GPG keyring
# TODO: Include GPG keys to management repository

# TODO: Add command add_mirror which adds components
#       cf. add_mirror debian-jessie jessie http://http.debian.net/debian

# TODO: Add local mirrors of
#        - geogebra
#        - vagrant ?
#       Add local repositories
#        - our custom packages
#        - packages done by others, built by us
# TODO: 

mkdir -p ${STAGEDIR}

add_keyring conf/gpg.d/debian-archive-keyring.gpg
add_keyring conf/gpg.d/geogebra.gpg

for component in ${COMPONENTS}
do
    add_mirror debian-${SUITE}-${component} ${SUITE} ${DEBIAN_MIRROR} conf/gpg.d/debian-archive-keyring.gpg ${component}
    
    for dist in ${DISTRIBUTIONS}
    do
        add_repository digabi-${dist}-${component}
        add_repository digabi-custom-${dist}-${component}
    done
done

if [ "$(stage remove-repository-geogebra-main-sources)" != "1" ]
then
    ${APTLYCMD} mirror drop geogebra-main
    remove_stage add-repository-geogebra-main
    set_stage remove-repository-geogebra-main-sources
fi

add_mirror geogebra-main stable http://www.geogebra.net/linux conf/gpg.d/geogebra.gpg main nosources
