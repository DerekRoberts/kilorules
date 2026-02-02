# Personal Kilo Rules Repository

This repository contains personal rules and preferences for Kilo Code AI assistant.

## Contents

- [`workflow.md`](workflow.md) - Git workflow and completion requirements
- [`communication.md`](communication.md) - Communication style preferences
- [`documentation.md`](documentation.md) - Documentation formatting guidelines
- [`personal-rules.md`](personal-rules.md) - This file

## Purpose

These are personal, experimental, and more assertive rules that supplement shared configuration. They help Kilo understand project-specific conventions, architecture decisions, and development patterns.

## Rule Placement Philosophy

Rules are split between this repository and SHARED_INSTRUCTIONS_PATH:

### This Repository (KILORULES_PATH/rules/)

Contains **personal, experimental, and more assertive** rules:

- **Personal preferences** - Tone, communication style, workflow expectations
- **Experimental approaches** - New patterns being tested before wider adoption
- **Strong opinions** - Assertive rules that may differ from standard practices
- **Project-specific conventions** - Rules unique to your projects

**Examples:**
- "Use conversational, informal tone" (personal preference)
- "Be intrusive and question everything" (assertive style)
- "A task is NOT complete until committed and pushed" (strong opinion)

### Shared Instructions (SHARED_INSTRUCTIONS_PATH)

Contains **safe, proven, obvious best practices**:

- **General coding standards** - Language-agnostic best practices
- **Documentation guidelines** - Standard markdown, code block formatting
- **Security patterns** - Established security best practices
- **Well-established conventions** - Widely-accepted patterns

**Examples:**
- "Use 4-space indentation for code blocks in release notes"
- "Never include personal names in documentation"
- Standard linting rules, formatting conventions

## Promotion Process

1. Test experimental rules in KILORULES_PATH/rules/ first
2. Once validated and refined, promote to SHARED_INSTRUCTIONS_PATH
3. Remove or de-emphasize the promoted rule in this repository
