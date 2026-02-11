#!/bin/bash
# Metrics Tracker - Analyze AI instruction file complexity
# Reports metrics with practitioner-informed thresholds
#
# Threshold rationale:
# - No rigorous published research exists on optimal system prompt length
# - OpenAI/Anthropic docs: structured prompts with headers tolerate more length
# - Practitioner consensus: ~500-1500 words sweet spot, >2500 dilutes signal
# - First 5-10 rules carry disproportionate weight (ordering matters)
# - Structure and specificity matter more than raw word count
# - Hard rules (MUST/NEVER) compete for attention; soft language (Prefer) is valid
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
    local lines words chars headers must_rules never_rules soft_rules
    lines=$(wc -l < "$file")
    words=$(wc -w < "$file")
    chars=$(wc -m < "$file")
    headers=$(grep -c '^## ' "$file" 2>/dev/null || true)
    must_rules=$(grep -Eiwc 'MUST|ALWAYS' "$file" 2>/dev/null || true)
    never_rules=$(grep -iwc 'NEVER' "$file" 2>/dev/null || true)
    soft_rules=$(grep -Eiwc 'Should|Consider|Prefer|Try' "$file" 2>/dev/null || true)

    # Ensure all counts are numeric
    headers=${headers:-0}
    must_rules=${must_rules:-0}
    never_rules=${never_rules:-0}
    soft_rules=${soft_rules:-0}

    # Thresholds
    # Words: <1500 optimal, 1500-2500 acceptable, >2500 action needed
    # Sections: <15 optimal, 15-25 acceptable, >25 consolidate
    # Hard rules (MUST+NEVER): <20 optimal, 20-35 acceptable, >35 action needed
    # Lines: informational only (code blocks skew line counts)
    # Soft language: informational only (Prefer/Consider are valid for preferences)
    local words_opt=1500 words_warn=2500
    local sections_opt=15 sections_warn=25
    local rules_opt=20 rules_warn=35

    # Display metrics
    local total_rules=$((must_rules + never_rules))
    echo "METRIC:                       TARGET:                     VALUE:"
    printf "  %-27s %-27s %s\n" "Words" "<$words_opt (opt), <$words_warn (warn)" "$words"
    printf "  %-27s %-27s %s\n" "Characters" "informational" "$chars"
    printf "  %-27s %-27s %s\n" "Sections (##)" "<$sections_opt (opt), <$sections_warn (warn)" "$headers"
    printf "  %-27s %-27s %s\n" "Hard rules (MUST+NEVER)" "<$rules_opt (opt), <$rules_warn (warn)" "$total_rules"
    printf "  %-27s %-27s %s\n" "Lines" "informational" "$lines"
    printf "  %-27s %-27s %s\n" "Soft language" "informational" "$soft_rules"
    echo ""

    # Assessment
    echo "ASSESSMENT:"
    local issues=0

    # Words assessment
    if [[ $words -lt $words_opt ]]; then
        echo "  ✅ Words: Optimal (<$words_opt)"
    elif [[ $words -le $words_warn ]]; then
        echo "  ⚠️  Words: Acceptable ($words words)"
        issues=$((issues + 1))
    else
        echo "  ❌ Words: Too long ($words words, target <$words_warn)"
        issues=$((issues + 1))
    fi

    # Sections assessment
    if [[ $headers -lt $sections_opt ]]; then
        echo "  ✅ Sections: Well-organized (<$sections_opt)"
    elif [[ $headers -le $sections_warn ]]; then
        echo "  ⚠️  Sections: Acceptable ($headers sections)"
        issues=$((issues + 1))
    else
        echo "  ❌ Sections: Too many ($headers - consolidate)"
        issues=$((issues + 1))
    fi

    # Hard rules assessment
    if [[ $total_rules -lt $rules_opt ]]; then
        echo "  ✅ Hard rules: Optimal (<$rules_opt)"
    elif [[ $total_rules -le $rules_warn ]]; then
        echo "  ⚠️  Hard rules: Acceptable ($total_rules rules)"
        issues=$((issues + 1))
    else
        echo "  ❌ Hard rules: Too many ($total_rules - prioritize essential only)"
        issues=$((issues + 1))
    fi

    echo ""
    if [[ $issues -eq 0 ]]; then
        echo "📈 Overall: Clear, well-structured instructions"
    elif [[ $issues -le 2 ]]; then
        echo "📈 Overall: Minor issues - review flagged items"
    else
        echo "📈 Overall: Needs attention - consider restructuring"
    fi
    echo ""
}

# Main execution
readonly DEFAULT_INSTRUCTIONS="$HOME/.copilot.md"

# Handle help flag
if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
    echo "Usage: $0 [file]"
    echo ""
    echo "Analyze AI instruction file complexity with practitioner-informed thresholds."
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
