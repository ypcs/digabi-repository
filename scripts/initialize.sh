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

for component in ${COMPONENTS}
do
    add_mirror debian-${SUITE}-${component} ${SUITE} ${DEBIAN_MIRROR} conf/gpg.d/debian-archive-keyring.gpg ${component}
    
    for stage in ${STAGES}
    do
        add_repository digabi-${stage}-${component}
        add_repository digabi-custom-${stage}-${component}
    done

    add_repository digabi-overrides-${component}
done

