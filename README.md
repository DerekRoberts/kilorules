# Kilo Rules

Personal rules and configuration for Kilo Code AI assistant.

## Purpose

These rules configure Kilo's AI assistant behavior to match personal preferences and workflow requirements. They complement shared team standards (like BCGov's copilot-instructions) with personal preferences.

**Why both sets?**
- `./rules/` = Personal preferences (communication style, workflow requirements, etc.)
- `https://github.com/bcgov/copilot-instructions/blob/main/.github/copilot-instructions.md` = Shared team/work standards
- Together they provide complete context: shared standards + personal preferences

### Rule Placement Philosophy

Rules are split between this repository and shared instructions:

#### This Repository (`rules/`)

Contains **personal, experimental, and more assertive** rules:

- **Personal preferences** - Tone, communication style, workflow expectations
- **Experimental approaches** - New patterns being tested before wider adoption
- **Strong opinions** - Assertive rules that may differ from standard practices
- **Project-specific conventions** - Rules unique to your projects

Examples:
- "Use conversational, informal tone" (personal preference)
- "Be intrusive and question everything" (assertive style)
- "A task is NOT complete until committed and pushed" (strong opinion)

#### Shared Instructions

Contains **safe, proven, obvious best practices**:

- **General coding standards** - Language-agnostic best practices
- **Documentation guidelines** - Standard markdown, code block formatting
- **Security patterns** - Established security best practices
- **Well-established conventions** - Widely-accepted patterns

Examples:
- "Use 4-space indentation for code blocks in release notes"
- "Never include personal names in documentation"
- Standard linting rules, formatting conventions

### Promotion Process

1. Test experimental rules in `rules/` first
2. Once validated and refined, promote to shared instructions
3. Remove or de-emphasize the promoted rule in this repository

## Structure

- [`README.md`](README.md) - This file (for humans, not read by Kilo)
- [`rules/`](rules/) - Directory containing Kilo rule files
- [`generate-copilot-instructions.sh`](generate-copilot-instructions.sh) - Script to generate `~/.copilot.md`

### Rule Files

The following files are in the [`rules/`](rules/) directory:

- [`rules/developer-profile.md`](rules/developer-profile.md) - Developer role, preferences, and working style
- [`rules/ai-behavior.md`](rules/ai-behavior.md) - AI communication style and assertive feedback behavior (experimental)
- [`rules/workflow.md`](rules/workflow.md) - AI-driven git commit and push workflow (personal preference)

## Setup

1. **Symlink personal rules:**

```bash
mkdir -p ~/.kilocode
ln -sf "$(pwd)/rules" ~/.kilocode/rules
```

2. **Symlink shared rules (optional):**

```bash
ln -sf ~/Repos/copilot-instructions/.github/copilot-instructions.md ~/.kilocode/rules/copilot-instructions.md
```

The first command keeps your personal rules version controlled. The second adds shared team standards.  Make sure to handle machine-specific paths to suit your setup.

## Updates

Pull the latest changes from this repository:

```bash
git pull
```

Kilo will automatically reload rules on next conversation.

## Customization

Edit files in `rules/` to match your preferences. Key sections:

- **Developer Profile** - Your role, preferences, and working style ([`rules/developer-profile.md`](rules/developer-profile.md))
- **AI Behavior** - How AI should communicate and provide feedback ([`rules/ai-behavior.md`](rules/ai-behavior.md))
- **Workflow** - AI-driven git commit and push workflow ([`rules/workflow.md`](rules/workflow.md))

### Generating ~/.copilot.md

This repository includes a script to generate a single `~/.copilot.md` file that aggregates all rules for easy use in new terminal sessions:

```bash
# Ensure the script is executable (if needed)
chmod +x generate-copilot-instructions.sh

# Run the generator
./generate-copilot-instructions.sh
```

This generates `~/.copilot.md` containing:
- External shared rules from `../copilot-instructions/.github/copilot-instructions.md`
- Local rules from `rules/` in the order: `developer-profile.md`, `ai-behavior.md`, `workflow.md`

**Configuration:**
- The script looks for the external copilot-instructions repository at `../copilot-instructions/` by default
- Override this path by setting the `COPILOT_INSTRUCTIONS_DIR` environment variable
- The order of rules in the output is hardcoded; new rule files added to `rules/` will not be automatically included - update the script's rule loop to add them

**Important Notes:**
- The script creates a backup of the existing `~/.copilot.md` before overwriting it
- Run this script after updating any rules to regenerate the aggregated file
- Warnings during generation are written to stderr so they don't appear in the generated output file
