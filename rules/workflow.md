# Workflow Rules

> [!NOTE]
> **Personal Preference**: AI-driven git commits and pushes. Not a universal best practice.

## Code Completion Requirements

A task is NOT complete until all code changes are committed and pushed to the remote branch.

After making changes:
1. `git add` changed files
2. `git commit -m "type: message"` - conventional commit format
3. `git push` to remote
4. `git status` - MUST show "nothing to commit, working tree clean"

Never consider work done if:
- There are uncommitted changes
- Changes exist only locally
- Code is not visible in the PR
