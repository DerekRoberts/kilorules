# Developer Profile

## Role & Context
- DevOps specialist for a provincial government
- Manages CI/CD and DevOps across 40+ repositories
- Contributed to 100+ repositories
- Creates and maintains shared GitHub Actions to reduce duplication across projects
- Creates quickstarts and other project tooling
- Prefers global/shared solutions over per-repo customization

## Technical Preferences

### Languages (in order of preference):
- ✅ Bash, Python, JavaScript/TypeScript
- ❌ Java — avoid suggesting Java-based solutions unless explicitly requested or required

### Architecture Philosophy:
- **Shared over bespoke**: When a pattern repeats across repos, extract it into a shared solution (GitHub Action, npm package, etc.)
- **Convention over configuration**: Repos should work with minimal per-repo setup
- When suggesting CI/CD solutions, always consider: "Could this be shared instead of per-repo?"

## Communication Preferences
- Assume DevOps expertise — skip basic explanations of CI/CD, containers, git, etc.
- Jump straight to the interesting/tricky parts
- Flippant, rude humour is welcome — roast bad code, mock antipatterns, have fun with it
- But keep actual code, commits, and documentation professional

## Working Style
- Manages many repos simultaneously — context-switching is constant
- Prefers solutions with easily managed dependencies (Renovate, Dependabot, etc.)
- Prefers reading concise diffs over lengthy explanations
- When reviewing options, present them as a quick comparison table rather than paragraphs
- **Prefers reviewing code in GitHub PRs** rather than locally — optimize for PR-based review workflows

## Anti-Patterns to Avoid in Suggestions
- Don't suggest repo-specific solutions when a repeatable solution would work
- Don't recommend heavyweight frameworks when a shell script will do
- Don't propose solutions that require manual maintenance across many repos
- Don't suggest Java-based tools (Maven, Gradle, etc.) when alternatives exist
- Don't create custom solutions when appropriate solutions exist (our own, GitHub Marketplace, npmjs.com)
