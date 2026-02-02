# Kilo Rules

Personal rules and configuration for Kilo Code AI assistant.

## Purpose

These rules configure Kilo's AI assistant behavior to match personal preferences and workflow requirements. They complement shared team standards (like BCGov's copilot-instructions) with personal preferences.

**Why both files?**
- `YOUR_KILORULES_PATH/rules/` = Personal preferences (communication style, workflow requirements, etc.)
- `SHARED_COPILOT_INSTRUCTIONS_PATH/copilot-instructions.md` = Shared team/work standards
- Together they provide complete context: shared standards + personal preferences

## Structure

- [`README.md`](README.md) - This file (for humans, not read by Kilo)
- [`rules/`](rules/) - Directory containing Kilo rule files

### Rule Files

The following files are in the [`rules/`](rules/) directory and should be symlinked to `~/.kilocode/rules`:

- [`rules/workflow.md`](rules/workflow.md) - Git completion requirements and workflow rules
- [`rules/communication.md`](rules/communication.md) - Communication style and active feedback rules
- [`rules/documentation.md`](rules/documentation.md) - Markdown formatting and documentation guidelines
- [`rules/personal-rules.md`](rules/personal-rules.md) - Repository overview and philosophy

## Setup

From your kilorules repository directory, run:

```bash
mkdir -p ~/.kilocode
ln -sf ./rules ~/.kilocode/rules
```

This makes all rule files available to Kilo Code without including this README.

## Customization

Edit files in `rules/` to match your preferences. Key sections:

- **Code Completion Requirements** - Workflow enforcement (rules/workflow.md)
- **Communication Style** - How AI should interact (rules/communication.md)
- **Documentation Guidelines** - Markdown formatting (rules/documentation.md)
- **Rule Placement Philosophy** - How to organize rules (rules/personal-rules.md)

## Updates

Pull the latest changes:

```bash
cd YOUR_KILORULES_PATH
git pull
```

Kilo will automatically reload rules on next conversation.
