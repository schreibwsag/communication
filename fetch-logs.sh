#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-//...}"
LOG_DIR="bazel_fetch_logs"
RAW_BEP="${LOG_DIR}/bep_raw.json"
URLS_FILE="${LOG_DIR}/unique_urls.txt"

mkdir -p "$LOG_DIR"

echo "Cleaning Bazel cache to force repository downloads..."
bazel clean --expunge

echo "Running Bazel and capturing BEP event log..."
bazel build "$TARGET" \
  --build_event_json_file="$RAW_BEP" \
  --experimental_ui_debug_all_events \
  --announce_rc \
  --verbose_failures \
  --sandbox_debug \
  --subcommands

echo "Extracting URLs..."

# Extract only http/https URLs and deduplicate
grep -Eo '"https?://[^"]+"' "$RAW_BEP" \
  | sed 's/"//g' \
  | sort -u \
  > "$URLS_FILE"

echo "Done. Unique URLs saved to: $URLS_FILE"

