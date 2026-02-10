#!/bin/bash
# Metrics Tracker - Analyze copilot-instructions.md complexity
# Reports metrics with research-backed thresholds
#
# Research basis (Perplexity, 2025):
# - Aim for ~1,000 words (50-80 short bullets or 20-30 detailed bullets)
# - If >60 lines, split into sections or separate files
# - First 5-10 rules carry most weight
# - Longer prompts improve performance up to practical limits
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

    # Research-backed thresholds
    # Lines: <60 optimal, 60-100 warning, >100 split needed
    # Words: <1000 optimal, 1000-2000 warning, >2000 split needed
    # Sections: <10 optimal, 10-20 warning, >20 consolidate
    # Rules (MUST+NEVER): <30 based on 20-30 detailed bullets
    # UNCLEAR: 0 optimal - reword for clarity
    local lines_warn_min=60 lines_warn_max=100
    local words_warn_min=1000 words_warn_max=2000
    local sections_warn=20
    local rules_warn=30
    local unclear_warn=0

    # Display metrics with pass/fail
    echo "CURRENT:                     TARGET:                    VALUE:"
    printf "  %-26s %-23s %s\n" "Lines" "<$lines_warn_min (opt), <$lines_warn_max (warn)" "$lines"
    printf "  %-26s %-23s %s\n" "Words" "<$words_warn_min (opt), <$words_warn_max (warn)" "$words"
    printf "  %-26s %-23s %s\n" "Sections" "<$sections_warn" "$headers"
    printf "  %-26s %-23s %s\n" "Rules (MUST+NEVER)" "<$rules_warn" "$((must_rules + never_rules))"
    printf "  %-26s %-23s %s\n" "UNCLEAR" "$unclear_warn" "$unclear_rules"
    echo ""

    # Assessment
    echo "ASSESSMENT:"
    issues=0

    # Lines assessment
    if [[ $lines -lt $lines_warn_min ]]; then
        echo "  ✅ Lines: Optimal (<$lines_warn_min)"
    elif [[ $lines -le $lines_warn_max ]]; then
        echo "  ⚠️  Lines: Acceptable ($lines lines)"
        issues=$((issues + 1))
    else
        echo "  ❌ Lines: Consider splitting (> $lines_warn_max lines)"
        issues=$((issues + 1))
    fi

    # Words assessment
    if [[ $words -lt $words_warn_min ]]; then
        echo "  ✅ Words: Optimal (<$words_warn_min)"
    elif [[ $words -le $words_warn_max ]]; then
        echo "  ⚠️  Words: Acceptable ($words words)"
        issues=$((issues + 1))
    else
        echo "  ❌ Words: Consider splitting (> $words_warn_max words)"
        issues=$((issues + 1))
    fi

    # Sections assessment
    if [[ $headers -lt $sections_warn ]]; then
        echo "  ✅ Sections: Well-organized (<$sections_warn)"
    else
        echo "  ⚠️  Sections: Many sections ($headers - consider consolidation)"
        issues=$((issues + 1))
    fi

    # Rules assessment
    local total_rules=$((must_rules + never_rules))
    if [[ $total_rules -lt $rules_warn ]]; then
        echo "  ✅ Rules: Reasonable count (<$rules_warn)"
    else
        echo "  ⚠️  Rules: High count ($total_rules - prioritize essential only)"
        issues=$((issues + 1))
    fi

    # UNCLEAR assessment
    if [[ $unclear_rules -eq 0 ]]; then
        echo "  ✅ UNCLEAR: None (clear guardrails)"
    else
        echo "  ❌ UNCLEAR: $unclear_rules found (reword: use MUST/NEVER)"
        issues=$((issues + 1))
    fi

    echo ""
    if [[ $issues -eq 0 ]]; then
        echo "📈 Overall: Clear, enforceable guardrails"
    elif [[ $issues -le 2 ]]; then
        echo "📈 Overall: Minor issues - review flagged items"
    else
        echo "📈 Overall: Significant issues - consider restructuring"
    fi
    echo ""
}

# Main execution
readonly DEFAULT_INSTRUCTIONS="$HOME/.copilot.md"

# Handle help flag
if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
    echo "Usage: $0 [file]"
    echo ""
    echo "Analyze copilot instructions with research-backed thresholds."
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
