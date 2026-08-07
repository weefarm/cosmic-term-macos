#!/usr/bin/env bash
set -euo pipefail

# Package the release binary as a macOS .app bundle.
# Usage: ./package-macos.sh

APP_NAME="cosmic-term"
APP_BUNDLE="${APP_NAME}.app"
TARGET_DIR="target/release"
RES_DIR="res/macos"

echo "Building ${APP_BUNDLE} from ${TARGET_DIR}/${APP_NAME}..."

rm -rf "${TARGET_DIR}/${APP_BUNDLE}"
mkdir -p "${TARGET_DIR}/${APP_BUNDLE}/Contents/MacOS"
mkdir -p "${TARGET_DIR}/${APP_BUNDLE}/Contents/Resources"

cp "${TARGET_DIR}/${APP_NAME}" "${TARGET_DIR}/${APP_BUNDLE}/Contents/MacOS/${APP_NAME}"
chmod +x "${TARGET_DIR}/${APP_BUNDLE}/Contents/MacOS/${APP_NAME}"
cp "${RES_DIR}/Info.plist" "${TARGET_DIR}/${APP_BUNDLE}/Contents/Info.plist"
cp "${RES_DIR}/cosmic-term.icns" "${TARGET_DIR}/${APP_BUNDLE}/Contents/Resources/cosmic-term.icns"

# Validate the plist syntax
plutil -lint "${TARGET_DIR}/${APP_BUNDLE}/Contents/Info.plist"

# Ad-hoc code sign so Gatekeeper is happier
if command -v codesign >/dev/null 2>&1; then
    codesign --force --deep --sign - "${TARGET_DIR}/${APP_BUNDLE}"
    echo "Ad-hoc signed ${APP_BUNDLE}."
fi

echo "Created ${TARGET_DIR}/${APP_BUNDLE}"
echo "Install with: cp -R ${TARGET_DIR}/${APP_BUNDLE} /Applications/"
