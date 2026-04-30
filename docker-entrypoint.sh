#!/bin/sh
set -e

DIST=/usr/share/nginx/html

# Replace a value in all compiled JS files, only if the env var is set
replace() {
  local old="$1" new="$2"
  [ -n "$new" ] || return 0
  find "$DIST" -name "*.js" -exec sed -i "s|$old|$new|g" {} \;
}

replace "https://overpass-api.de/api/"                   "$DEFAULT_SERVER"
replace "https://tile.openstreetmap.org/{z}/{x}/{y}.png" "$DEFAULT_TILES"

exec nginx -g "daemon off;"
