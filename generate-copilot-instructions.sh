#!/bin/bash
#
# Generate ~/.copilot.md from all rule files
# Usage: ./generate-copilot-instructions.sh
#
# Environment Variables:
#   COPILOT_INSTRUCTIONS_DIR: Path to external copilot-instructions repository
#                            (default: ../copilot-instructions relative to script)
#
# Requirements:
#   - Bash 4.0+ (for ${var^} parameter expansion)
#   - On macOS, install via: brew install bash
#

set -e

# Enable nullglob so empty globs expand to empty array instead of literal pattern
shopt -s nullglob

# Check bash version (require 4.0+ for ${var^} capitalization)
if ((BASH_VERSINFO[0] < 4)); then
    echo "Error: This script requires bash 4.0 or later (current: ${BASH_VERSION})" >&2
    echo "On macOS, install via: brew install bash" >&2
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_FILE="${HOME}/.copilot.md"

# External copilot-instructions (local copy) - configurable via environment variable
COPILOT_INSTRUCTIONS_DIR="${COPILOT_INSTRUCTIONS_DIR:-${SCRIPT_DIR}/../copilot-instructions}"
EXTERNAL_FILE="${COPILOT_INSTRUCTIONS_DIR}/.github/copilot-instructions.md"
LOCAL_RULES_DIR="${SCRIPT_DIR}/rules"

# Backup and confirmation for existing file
if [[ -f "$OUTPUT_FILE" ]]; then
    read -p "$OUTPUT_FILE already exists. Overwrite? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 1
    fi
    cp "$OUTPUT_FILE" "${OUTPUT_FILE}.backup"
    echo "Backup created: ${OUTPUT_FILE}.backup" >&2
fi

{
    echo "# Copilot Instructions"
    echo ""
    echo "_Auto-generated from generate-copilot-instructions.sh_"
    echo "_Do not edit manually - edit files in rules/ instead_"
    echo ""
    echo "---"
    echo ""

    # External shared rules
    if [[ -f "$EXTERNAL_FILE" ]]; then
        echo "## External Shared Rules"
        echo ""
        cat "$EXTERNAL_FILE"
        echo ""
        echo "---"
        echo ""
    else
        echo "Warning: External file not found at $EXTERNAL_FILE" >&2
    fi

    # Local rules from rules/ directory - dynamically discover all .md files
    echo "## Local Rules"
    echo ""
    rule_count=0
    for rule_file in "${LOCAL_RULES_DIR}"/*.md; do
        if [[ -f "$rule_file" ]]; then
            ((rule_count++))
            # Get base filename without path and extension
            rule_name=$(basename "$rule_file" .md)
            # Capitalize first letter for title
            rule_title="${rule_name^}"
            echo "### ${rule_title} Rules"
            echo ""
            # Skip the first markdown title line (format: "# Title")
            # This assumes each rule file starts with a level-1 heading on line 1
            awk 'NR > 1' "$rule_file"
            echo ""
        fi
    done

    if [[ $rule_count -eq 0 ]]; then
        echo "Warning: No rule files found in ${LOCAL_RULES_DIR}" >&2
    fi

    echo "---"
    echo ""
    echo "_Generated at $(date -u +'%Y-%m-%dT%H:%M:%SZ')_"

} > "$OUTPUT_FILE"

echo "Generated: $OUTPUT_FILE"

# Run metrics analysis on combined output (Kilo + Copilot rules)
echo ""
bash "${SCRIPT_DIR}/scripts/metrics-tracker.sh" "$OUTPUT_FILE"
