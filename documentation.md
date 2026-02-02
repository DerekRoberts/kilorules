# Documentation Rules

## 📝 Markdown & Documentation Formatting

### Code Blocks in Release Notes & Documentation:
- **Avoid triple backticks (```)** when creating code blocks that will be used in GitHub releases or other contexts where triple backticks may break formatting
- **Use 4-space indentation** instead for code blocks in release notes, documentation, or any content that will be pasted into systems that don't handle triple backticks well
- Triple backticks are fine for regular markdown files, but use indented code blocks when the content might be used in contexts where ``` breaks the formatting

**Example:**
    # Use 4-space indentation for code blocks
    - uses: bcgov-nr/action-diff-triggers@v1.0.0
      with:
        triggers: ('backend/' 'frontend/')

## Privacy in Documentation

**When creating or editing documentation (README.md, etc.):**
- **NEVER include personal names** - use generic placeholders like "YOUR_USERNAME" or "user"
- **NEVER include specific folder structures** - use generic paths like `~/workspace` rather than specific directory names
- **NEVER include personal identifiers** - keep examples generic and applicable to anyone
- Use placeholders (`YOUR_USERNAME`, `~/workspace`, etc.) that users can replace with their own values
