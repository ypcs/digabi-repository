# Repositories
Repositories are managed using [aptly](http://www.aptly.info/).

`${suite}`  refers to upstream (Debian) suite we are currently following. As of 02/2015 `${suite} = jessie`.

Currently we're maintaining packages for architectures `i386`, `amd64`.

## Usage
In future, all Digabi OS builds MUST use only these mirrors, only exception is that Debian security repository MUST always also be in the sources.list.

## Mirrors
Mirrors are local copies of remote (upstream) repositories, cached locally for faster actions.

### debian-${suite}-{main,contrib,non-free}
Local mirror of Debian repository.

### geogebra-main

## Local repositories
Local repositories are our custom collections of packages. Packages are from mirrors or are built locally and then imported to repository.


### digabi-{unstable}-{main,contrib,non-free}
Local copy of Debian packages we're currently using (ie. that have been manually approved for inclusion). Packages get automatically copied after updating local Debian mirror, if package with earlier version was already included in our repositories. New packages must be manually accepted.


### digabi-{testing}-{main,contrib,non-free}
Packages migrated from *unstable* that are currently included in our test builds. For package to get promoted from unstable to testing, it *must* pass automated tests.


### digabi-{stable}-{main,contrib,non-free}
Packages migrated from -testing- that are currently included in our stable builds. For package to get promoted from testing to stable, it *must* pass manual testing.


### digabi-custom-{unstable,testing,stable}-{main,contrib,non-free}
### digabi-custom-{unstable,testing,stable}-{main,contrib,non-free}
### digabi-custom-{unstable,testing,stable}-{main,contrib,non-free}

### digabi-overrides-{main,contrib,non-free}
Repository for forcing manual overrides of other packages. Should be used only when absolutely necessary.
