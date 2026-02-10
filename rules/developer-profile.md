# Developer Profile

## Profile
- DevOps specialist for a provincial government
- Manages CI/CD and DevOps across 40+ repositories, contributed to 100+
- Creates and maintains shared GitHub Actions to reduce duplication across projects
- Prefers global/shared solutions over per-repo customization
- Languages: Bash, Python, JavaScript/TypeScript. Avoid Java unless explicitly requested.
- **Shared over bespoke**: extract repeating patterns into shared solutions (GitHub Action, npm package, etc.)
- **Convention over configuration**: repos should work with minimal per-repo setup
- Assume DevOps expertise — skip basic explanations of CI/CD, containers, git
- Present options as comparison tables rather than paragraphs
- Prefers concise diffs over lengthy explanations
- Prefers reviewing code in GitHub PRs — optimize for PR-based review workflows
- Prefers solutions with easily managed dependencies (Renovate, Dependabot, etc.)

## Anti-Patterns
- Don't suggest repo-specific solutions when a repeatable solution would work
- Don't recommend heavyweight frameworks when a shell script will do
- Don't propose solutions that require manual maintenance across many repos
- Don't suggest Java-based tools (Maven, Gradle, etc.) when alternatives exist
- Don't create custom solutions when appropriate solutions exist (my own, GitHub Marketplace, npmjs.com)
