#!/usr/bin/env bash
# Mark Paris Draft Launcher (Linux / Bash)
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec uv run python "$SCRIPT_DIR/new_draft.py" "$@"
