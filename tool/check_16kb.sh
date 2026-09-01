#!/usr/bin/env bash
# Verifies that an APK or AAB meets Google Play's 16 KB memory page size
# requirement, which applies to apps targeting Android 15+.
#
# Two things have to hold, and passing one does not imply the other:
#   1. every 64-bit .so has LOAD segments aligned to at least 16384 bytes
#   2. (APK only) each .so starts at a 16 KB-aligned offset inside the zip
#
# Usage: tool/check_16kb.sh [path-to-apk-or-aab]
# Defaults to the release APK if no path is given.

set -euo pipefail

ARTIFACT="${1:-build/app/outputs/flutter-apk/app-release.apk}"
[ -f "$ARTIFACT" ] || { echo "No such file: $ARTIFACT" >&2; exit 1; }

SDK="${ANDROID_HOME:-${ANDROID_SDK_ROOT:-$HOME/Library/Android/sdk}}"
READELF=$(find "$SDK/ndk" -name llvm-readelf \( -type f -o -type l \) 2>/dev/null | sort | tail -1)
[ -n "$READELF" ] || { echo "llvm-readelf not found under $SDK/ndk" >&2; exit 1; }

WORK=$(mktemp -d)
trap 'rm -rf "$WORK"' EXIT
unzip -o -q "$ARTIFACT" '*lib/*' -d "$WORK" || true

status=0

# 16 KB pages only exist on 64-bit ABIs; armeabi-v7a is exempt.
while IFS= read -r so; do
  align=$("$READELF" -l "$so" 2>/dev/null | awk '/LOAD/ {print $NF}' | sort -u | tail -1)
  if [ -z "$align" ] || [ "$((align))" -lt 16384 ]; then
    printf 'FAIL  %-48s align=%s\n' "${so#"$WORK"/}" "${align:-none}"
    status=1
  else
    printf 'ok    %-48s align=%s\n' "${so#"$WORK"/}" "$align"
  fi
done < <(find "$WORK" -path '*arm64-v8a*' -name '*.so' -o -path '*x86_64*' -name '*.so' | sort)

if [[ "$ARTIFACT" == *.apk ]]; then
  echo
  ZIPALIGN=$(find "$SDK/build-tools" -name zipalign \( -type f -o -type l \) 2>/dev/null | sort | tail -1)
  if [ -n "$ZIPALIGN" ]; then
    if "$ZIPALIGN" -c -P 16 -v 4 "$ARTIFACT" >/dev/null 2>&1; then
      echo "ok    zip alignment (-P 16)"
    else
      echo "FAIL  zip alignment (-P 16)"
      status=1
    fi
  else
    echo "warn  zipalign not found; skipped the zip alignment check"
  fi
fi

echo
[ $status -eq 0 ] && echo "16 KB compliance: PASS" || echo "16 KB compliance: FAIL"
exit $status
