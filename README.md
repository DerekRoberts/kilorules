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
