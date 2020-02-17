#!/usr/bin/env sh

set -e

ar p teams.deb data.tar.xz | tar -xJf -

mv usr/share/teams .

rm -rf teams.deb usr
