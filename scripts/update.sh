#!/usr/bin/env bash
set -euo pipefail

echo "=== [GAJIANICH Server Agent Update] Starting auto-update at $(date) ==="
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AGENT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

cd "${AGENT_DIR}"

if [ -d ".git" ]; then
  echo "-> Pulling latest code from git repository..."
  git fetch origin main || git fetch --all || true
  git pull origin main || true
else
  echo "-> Notice: No .git directory found, skipping git pull."
fi

echo "-> Installing production dependencies..."
npm install --omit=dev --no-audit --no-fund

echo "-> Building TypeScript artifacts..."
npm run build

echo "=== [GAJIANICH Server Agent Update] Finished successfully at $(date) ==="
