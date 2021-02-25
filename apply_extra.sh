#!/usr/bin/env sh

set -e

ar p teams.deb data.tar.xz | tar -vxJ --exclude=rect-overlay

mv usr/share/teams .

rm -rf teams.deb usr
