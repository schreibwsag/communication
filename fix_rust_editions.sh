#!/usr/bin/env bash

set -e

# Find all BUILD files
find . -type f \( -name BUILD -o -name BUILD.bazel \) | while read -r file; do
    echo "Processing $file"

    # Use awk to rewrite the file safely
    awk '
        # Track whether we are inside a rust rule
        /rust_library\(/ || /rust_binary\(/ || /rust_test\(/ || /rust_proc_macro\(/ {
            in_rust_rule = 1
        }

        # Detect edition already present
        in_rust_rule && /edition *=/ {
            has_edition = 1
        }

        # When we hit the closing parenthesis of a rust rule
        in_rust_rule && /^\)/ {
            if (!has_edition) {
                print "    edition = \"2021\","
            }
            in_rust_rule = 0
            has_edition = 0
        }

        # Always print the current line
        { print }
    ' "$file" > "$file.tmp"

    mv "$file.tmp" "$file"
done

echo "Done."
