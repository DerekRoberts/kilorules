#!/bin/bash
#
# Regenerate copilot-instructions.md from all rule files
# Usage: ./scripts/generate-copilot-instructions.sh [--github]
#

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_FILE="${SCRIPT_DIR}/../copilot-instructions.md"

# Determine source for external copilot-instructions
EXTERNAL_FILE=""
if [[ "$1" == "--github" ]]; then
    # Fetch latest from GitHub (requires gh CLI or wget/curl)
    EXTERNAL_CONTENT=$(gh api repos/DerekRoberts/copilot-instructions/contents/.github/copilot-instructions.md --jq '.content' 2>/dev/null | base64 -d) \
        || EXTERNAL_CONTENT=$(curl -s https://raw.githubusercontent.com/DerekRoberts/copilot-instructions/main/.github/copilot-instructions.md) \
        || { echo "Warning: Could not fetch from GitHub, using local fallback"; EXTERNAL_FILE="../copilot-instructions/.github/copilot-instructions.md"; }
else
    # Use local file (default - more reliable)
    EXTERNAL_FILE="../copilot-instructions/.github/copilot-instructions.md"
fi

{
    echo "# Copilot Instructions"
    echo ""
    echo "_Auto-generated from scripts/generate-copilot-instructions.sh_"
    echo "_Do not edit manually - edit files in rules/ instead_"
    echo ""
    echo "---"
    echo ""

    # External shared rules
    if [[ -n "$EXTERNAL_FILE" && -f "$EXTERNAL_FILE" ]]; then
        echo "## External Shared Rules"
        echo ""
        echo "_Source: $EXTERNAL_FILE_"
        echo ""
        cat "$EXTERNAL_FILE"
        echo ""
        echo "---"
        echo ""
    elif [[ -n "$EXTERNAL_CONTENT" ]]; then
        echo "## External Shared Rules"
        echo ""
        echo "_Source: GitHub (DerekRoberts/copilot-instructions)_"
        echo ""
        echo "$EXTERNAL_CONTENT"
        echo ""
        echo "---"
        echo ""
    fi

    # Local rules from rules/ directory
    echo "## Local Rules"
    echo ""
    for rule in communication documentation workflow; do
        if [[ -f "${SCRIPT_DIR}/../rules/${rule}.md" ]]; then
            echo "### $(echo "$rule" | sed 's/^\(.\)/\U\1/') Rules"
            echo ""
            cat "${SCRIPT_DIR}/../rules/${rule}.md"
            echo ""
        fi
    done

    echo "---"
    echo ""
    echo "_Generated at $(date -Iseconds)_"

} > "$OUTPUT_FILE"

echo "Generated: $OUTPUT_FILE"
