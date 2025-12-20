#!/bin/bash
set -e

# --- Patch NVENC ---
echo "/patched-lib" > /etc/ld.so.conf.d/000-patched-lib.conf
mkdir -p "/patched-lib"
PATCH_OUTPUT_DIR=/patched-lib /usr/local/bin/patch.sh

cd /patched-lib || exit 1
for f in * ; do
    suffix="${f##*.so}"
    name="$(basename "$f" ".$suffix")"
    [ ! -e "$name" ] && ln -sf "$f" "$name"
    [ ! -e "$name.1" ] && ln -sf "$f" "$name.1"
done
ldconfig
[ "$OLDPWD" ] && cd -

# --- Executar entrypoint original do plugin PostgreSQL ---
exec /usr/local/bin/original-entrypoint.sh "$@"
