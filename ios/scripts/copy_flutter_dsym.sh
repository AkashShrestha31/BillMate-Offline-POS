#!/bin/sh
set -euo pipefail

# Xcode 16+ requires a dSYM for every embedded framework in App Store archives.
# Flutter's prebuilt engine often ships without a bundled dSYM, so generate one from
# the linked Flutter.framework binary (UUID must match the embedded framework).
case "${CONFIGURATION}" in
  *Release*|*Profile*) ;;
  *) exit 0 ;;
esac

FLUTTER_BINARY="${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/Flutter.framework/Flutter"
FLUTTER_DSYM="${DWARF_DSYM_FOLDER_PATH}/Flutter.framework.dSYM"

if [ ! -e "${FLUTTER_BINARY}" ]; then
  echo "note: Flutter.framework binary not found, skipping dSYM generation"
  exit 0
fi

if [ -e "${FLUTTER_DSYM}" ]; then
  echo "Flutter.framework.dSYM already present"
  exit 0
fi

echo "Generating Flutter.framework.dSYM for App Store archive..."
/usr/bin/dsymutil "${FLUTTER_BINARY}" -o "${FLUTTER_DSYM}"
