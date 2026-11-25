#!/usr/bin/env bash
# Validates Google Play store listing text limits (Unicode code points).
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
METADATA_ROOT="${SCRIPT_DIR}/metadata/android"

if [[ ! -d "${METADATA_ROOT}" ]]; then
  echo "ERROR: metadata folder not found: ${METADATA_ROOT}" >&2
  exit 1
fi

python3 - "${METADATA_ROOT}" <<'PY'
import sys
from pathlib import Path

root = Path(sys.argv[1])
limits = {
    "title.txt": 30,
    "short_description.txt": 80,
    "full_description.txt": 4000,
}

errors = []
checked = 0

for locale_dir in sorted(p for p in root.iterdir() if p.is_dir()):
    for filename, max_len in limits.items():
        path = locale_dir / filename
        if not path.exists():
            errors.append(f"{locale_dir.name}: missing {filename}")
            continue

        text = path.read_text(encoding="utf-8").rstrip("\n")
        length = len(text)
        checked += 1

        if not text.strip():
            errors.append(f"{locale_dir.name}/{filename}: empty")
        if length > max_len:
            errors.append(
                f"{locale_dir.name}/{filename}: {length} chars (max {max_len})"
            )

if errors:
    print("Play Store metadata validation FAILED:\n", file=sys.stderr)
    for err in errors:
        print(f"  - {err}", file=sys.stderr)
    sys.exit(1)

print(f"OK: validated {checked} metadata files under {root}")
PY
