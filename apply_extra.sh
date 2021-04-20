#!/usr/bin/env sh

set -e

bsdtar -Oxf teams.deb 'data.tar.*' |
  bsdtar -xf - \
    --strip-components=3 \
    --exclude='./usr/bin/' \
    --exclude='./usr/share/applications/' \
    --exclude='./usr/share/pixmaps/'

rm -rf teams.deb
