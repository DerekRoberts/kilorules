# Kilo Rules

Personal GitHub Copilot instructions combining shared BCGov standards with personal preferences.

## What it does

`generate-copilot-instructions.sh` concatenates:
- Shared BCGov team standards from `../copilot-instructions/.github/copilot-instructions.md`
- Personal preferences from all `*.md` files in `rules/`

Output: `~/.copilot.md` (read by GitHub Copilot)

## Usage

```bash
./generate-copilot-instructions.sh
```

Displays metrics after generation. Run after editing files in `rules/`.

## Structure

- `generate-copilot-instructions.sh` - Generator script
- `rules/` - Personal preference files (all `*.md` files concatenated)
- `scripts/metrics-tracker.sh` - Analyzes generated output complexity
