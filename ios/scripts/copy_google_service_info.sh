#!/bin/sh
set -e

PLIST="${GOOGLE_SERVICE_INFO_PLIST}"
if [ -z "${PLIST}" ]; then
  if echo "${CONFIGURATION}" | grep -qi "development"; then
    PLIST="${PROJECT_DIR}/Config/Development/GoogleService-Info.plist"
  else
    PLIST="${PROJECT_DIR}/Config/Production/GoogleService-Info.plist"
  fi
fi

DEST="${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist"
if [ ! -f "${PLIST}" ]; then
  echo "warning: GoogleService-Info.plist not found at ${PLIST}. Add your own Firebase plist to enable Analytics, push, and Remote Config." >&2
  exit 0
fi

mkdir -p "$(dirname "${DEST}")"
cp "${PLIST}" "${DEST}"
echo "Copied GoogleService-Info.plist from ${PLIST}"
