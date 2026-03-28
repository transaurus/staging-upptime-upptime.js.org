#!/usr/bin/env bash
set -euo pipefail

# Rebuild script for upptime/upptime.js.org
# Runs on an existing source tree (no clone). Installs deps and builds.
# The staging repo already has upgraded package.json, patched docusaurus.config.js,
# and .npmrc (legacy-peer-deps=true) from the prepare.sh phase.

# --- Node version ---
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
if [ -f "$NVM_DIR/nvm.sh" ]; then
    . "$NVM_DIR/nvm.sh"
    nvm install 20
    nvm use 20
fi
echo "[INFO] Node: $(node --version)"
echo "[INFO] npm: $(npm --version)"

# --- Remove lockfile if present (may be stale after translation changes) ---
rm -f package-lock.json

# --- Install dependencies ---
npm install

# --- Build Docusaurus site ---
# Use npx docusaurus build directly (npm run build also runs 'npm run site'
# which clones an external GitHub repo not needed for i18n pipeline)
npx docusaurus build

echo "[DONE] Build complete."
