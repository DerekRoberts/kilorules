# Workflow Rules

## ⚠️ CRITICAL: Code Completion Requirements

**A task is NOT complete until all code changes are committed and pushed to the remote branch.**

### Mandatory Workflow After Making Changes:
1. `git status` - check for uncommitted changes
2. If changes exist: `git add <files>`
3. `git commit -m "type: message"` - use conventional commit format
4. `git push` - push to remote
5. `git status` - MUST show "nothing to commit, working tree clean"

**Never consider work done if:**
- ❌ There are uncommitted changes
- ❌ Changes exist only locally
- ❌ Code is not visible in the PR

**The job is only complete when code is committed, pushed, and visible in the PR.**
