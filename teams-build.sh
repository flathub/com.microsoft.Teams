#!/usr/bin/env sh

set -eux

install -Dm0755 apply_extra.sh "${FLATPAK_DEST}/bin/apply_extra"
install -Dm0755 teams.sh "${FLATPAK_DEST}/bin/teams"
install -Dm0644 "${FLATPAK_ID}.metainfo.xml" "${FLATPAK_DEST}/share/metainfo/${FLATPAK_ID}.metainfo.xml"

bsdtar -Oxf teams.deb 'data.tar.*' |
  bsdtar -xf - \
    --strip-components=3 \
    --exclude='./usr/bin/' \
    --exclude='./usr/share/teams/'

install -Dm0644 applications/teams.desktop "${FLATPAK_DEST}/share/applications/${FLATPAK_ID}.desktop"
sed -i s:Exec=/usr/bin/teams:Exec=teams: "${FLATPAK_DEST}/share/applications/${FLATPAK_ID}.desktop"
desktop-file-edit --set-key="Icon" --set-value="${FLATPAK_ID}" "${FLATPAK_DEST}/share/applications/${FLATPAK_ID}.desktop"

for size in 64 128 264 512; do
    convert pixmaps/teams.png -resize ${size} "${FLATPAK_ID}.png"
    install -Dm0644 "${FLATPAK_ID}.png" "${FLATPAK_DEST}/share/icons/hicolor/${size}x${size}/apps/${FLATPAK_ID}.png"
done
