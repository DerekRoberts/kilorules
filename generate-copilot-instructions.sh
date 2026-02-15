#!/bin/bash
#
# Generate ~/.copilot.md from developer-profile.md
# Usage: ./generate-copilot-instructions.sh
#
# Environment Variables:
#   COPILOT_INSTRUCTIONS_DIR: Path to external copilot-instructions repository
#                            (default: ../copilot-instructions relative to script)
#

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_FILE="${HOME}/.copilot.md"

# External copilot-instructions (local copy) - configurable via environment variable
COPILOT_INSTRUCTIONS_DIR="${COPILOT_INSTRUCTIONS_DIR:-${SCRIPT_DIR}/../copilot-instructions}"
EXTERNAL_FILE="${COPILOT_INSTRUCTIONS_DIR}/.github/copilot-instructions.md"
LOCAL_RULES_DIR="${SCRIPT_DIR}/rules"

{
    # External shared rules
    if [[ -f "$EXTERNAL_FILE" ]]; then
        cat "$EXTERNAL_FILE"
        echo ""
    else
        echo "Warning: External file not found at $EXTERNAL_FILE" >&2
    fi

    # Local rules
    developer_profile="${LOCAL_RULES_DIR}/developer-profile.md"
    if [[ -f "$developer_profile" ]]; then
        cat "$developer_profile"
    else
        echo "Warning: developer-profile.md not found at $developer_profile" >&2
    fi

} > "$OUTPUT_FILE"

echo "Generated: $OUTPUT_FILE"
bash "${SCRIPT_DIR}/scripts/metrics-tracker.sh" "$OUTPUT_FILE"
