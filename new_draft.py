#!/usr/bin/env python3
"""
Mark Paris Draft Creation Script
Cross-platform helper to create daily numbered drafts in MarkParis/drafting/
with pre-populated YAML frontmatter, then launch Vim.
"""

import sys
import os
import re
import datetime
import subprocess
from pathlib import Path


def get_repo_root() -> Path:
    """Return the repository root directory (where this script resides)."""
    return Path(__file__).resolve().parent


def create_draft(open_editor: bool = True) -> Path:
    repo_root = get_repo_root()
    drafting_dir = repo_root / "MarkParis" / "drafting"
    drafting_dir.mkdir(parents=True, exist_ok=True)

    today = datetime.date.today()
    date_filename_prefix = today.strftime("%Y%m%d")
    date_frontmatter = today.strftime("%Y-%m-%d")

    # Find highest sequence number for today's files (e.g., 20260807_01.md)
    pattern = re.compile(rf"^{date_filename_prefix}_(\d+)\.md$")
    existing_indices = []

    for item in drafting_dir.iterdir():
        if item.is_file():
            match = pattern.match(item.name)
            if match:
                existing_indices.append(int(match.group(1)))

    next_idx = max(existing_indices) + 1 if existing_indices else 1
    filename = f"{date_filename_prefix}_{next_idx:02d}.md"
    file_path = drafting_dir / filename

    content = (
        "---\n"
        f"Date: {date_frontmatter}\n"
        "Timeline: \n"
        "Summary: \n"
        "---\n"
        "\n\n"
    )

    # Write file to disk immediately so it persists even if editor is closed without saving
    file_path.write_text(content, encoding="utf-8")

    if open_editor:
        editor = os.environ.get("EDITOR", "vim")
        # '+' tells Vim to position the cursor on the last line of the file (line after blank line)
        try:
            subprocess.run([editor, "+", str(file_path)])
        except FileNotFoundError:
            print(f"Error: Editor '{editor}' not found in PATH.", file=sys.stderr)
            sys.exit(1)

    return file_path


def main():
    open_editor = "--no-editor" not in sys.argv
    file_path = create_draft(open_editor=open_editor)
    print(f"Draft created: {file_path}")


if __name__ == "__main__":
    main()
