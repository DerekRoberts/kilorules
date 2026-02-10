#!/bin/bash
# Metrics Tracker - Analyze copilot-instructions.md complexity
# Reports basic metrics for review
#
# Usage:
#   ./metrics-tracker.sh [file]
#
# Arguments:
#   file    Path to instructions file (default: ~/.copilot.md)
#
# Examples:
#   $0                      # Analyze default file
#   $0 custom/instructions.md   # Analyze custom file

set -euo pipefail

analyze_instructions() {
    local file="$1"

    if [[ ! -f "$file" ]]; then
        echo "❌ File not found: $file"
        return 1
    fi

    echo "📊 METRICS: $file"
    echo "Generated: $(date)"
    echo ""

    # Get basic metrics
    local lines words headers must_rules never_rules unclear_rules
    lines=$(wc -l < "$file")
    words=$(wc -w < "$file")
    headers=$(grep -c '^##' "$file" 2>/dev/null || true)
    must_rules=$(grep -Eic 'MUST|ALWAYS' "$file" 2>/dev/null || true)
    never_rules=$(grep -ic 'NEVER' "$file" 2>/dev/null || true)
    unclear_rules=$(grep -Eic 'Should|Consider|Prefer|Try' "$file" 2>/dev/null || true)

    # Ensure all counts are numeric
    headers=${headers:-0}
    must_rules=${must_rules:-0}
    never_rules=${never_rules:-0}
    unclear_rules=${unclear_rules:-0}

    # Display metrics
    echo "METRICS:"
    echo "  Lines:    $lines"
    echo "  Words:    $words"
    echo "  Sections: $headers"
    echo "  MUST:     $must_rules"
    echo "  NEVER:    $never_rules"
    echo "  UNCLEAR:  $unclear_rules"
    echo ""
}

# Main execution
readonly DEFAULT_INSTRUCTIONS="$HOME/.copilot.md"

# Handle help flag
if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
    echo "Usage: $0 [file]"
    echo ""
    echo "Analyze copilot instructions for metrics."
    echo ""
    echo "Arguments:"
    echo "  file    Path to instructions file (default: $DEFAULT_INSTRUCTIONS)"
    echo ""
    echo "Examples:"
    echo "  $0                          # Analyze default file"
    echo "  $0 custom/instructions.md   # Analyze custom file"
    exit 0
fi

# Validate argument count
if [[ $# -gt 1 ]]; then
    echo "Error: Too many arguments. Expected 0 or 1, got $#" >&2
    echo "Run '$0 --help' for usage information." >&2
    exit 1
fi

local_file="${1:-$DEFAULT_INSTRUCTIONS}"

analyze_instructions "$local_file"
