#!/usr/bin/env bash
# Mark Paris Draft Launcher
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if command -v uv >/dev/null 2>&1; then
    exec uv run python "$SCRIPT_DIR/new_draft.py" "$@"
else
    exec python3 "$SCRIPT_DIR/new_draft.py" "$@"
fi

