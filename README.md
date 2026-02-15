# Kilo Rules

Personal GitHub Copilot instructions combining shared BCGov standards with personal preferences.

## What it does

`generate-copilot-instructions.sh` concatenates:
- Shared BCGov team standards from `../copilot-instructions/.github/copilot-instructions.md`
- Personal preferences from `rules/developer-profile.md`

Output: `~/.copilot.md` (read by GitHub Copilot)

## Usage

```bash
./generate-copilot-instructions.sh
```

Displays metrics after generation. Run after editing `rules/developer-profile.md`.

## Structure

- `generate-copilot-instructions.sh` - Generator script
- `rules/developer-profile.md` - Personal preferences (language prefs, communication style)
- `scripts/metrics-tracker.sh` - Analyzes generated output complexity
- `plans/` - Planning documents (not used by Copilot)

## Notes

`COPILOT_INSTRUCTIONS_DIR` environment variable can override the default `../copilot-instructions` path.

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
- Local rules in priority order (first rules carry most weight): `workflow.md`, `developer-profile.md`, `ai-behavior.md`

**Configuration:**
- The script looks for the external copilot-instructions repository at `../copilot-instructions/` by default
- Override this path by setting the `COPILOT_INSTRUCTIONS_DIR` environment variable
- Rule order is explicit in the `RULE_ORDER` array; new rule files must be added to this array

**Important Notes:**
- Run this script after updating any rules to regenerate the aggregated file
- Warnings during generation are written to stderr so they don't appear in the generated output file
