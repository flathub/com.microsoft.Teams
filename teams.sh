#!/usr/bin/env sh

set -e

timezone_workaround()
{
  if [ -n "$TZ" ]; then
    return
  fi

  if [ ! -f /etc/timezone ]; then
    return
  fi

  zone_name=$(cat /etc/timezone | sed -e 's/[[:space:]]*$//')

  if [ -z "$zone_name" ] || [ ! -f /usr/share/zoneinfo/"$zone_name" ]; then
    return
  fi

  export TZ="$zone_name"
  echo "Overriding TZ to $zone_name"
}

timezone_workaround

exec env TMPDIR="$XDG_CACHE_HOME" zypak-wrapper /app/extra/teams/teams "$@"
