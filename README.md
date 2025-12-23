# Claude Code Starter Files

Starter templates for [Claude Code](https://platform.claude.com/docs/en/intro) configuration.

## Files

| File | Purpose | Location |
|------|---------|----------|
| `CLAUDE.md` | Project-level instructions | Repo root (or `~/.claude/CLAUDE.md` for global) |
| `settings.json` | Permission rules | `~/.claude/settings.json` |
| `githooks/commit-msg` | Strips Claude taglines + validates conventional commits | `~/.git-hooks/` or repo `.git/hooks/` |

## Setup

### 1. CLAUDE.md

Copy to your project root and customize:
- Dev environment details
- Framework/tooling preferences
- Git workflow conventions

### 2. settings.json

Copy to `~/.claude/settings.json`. Adjust:
- `allow` - Auto-approved commands
- `ask` - Commands requiring confirmation
- `deny` - Blocked commands/file patterns
- `additionalDirectories` - Directories Claude can access

### 3. Git Hook

**Global (all repos):**
```bash
mkdir -p ~/.git-hooks
cp githooks/commit-msg ~/.git-hooks/
chmod +x ~/.git-hooks/commit-msg
git config --global core.hooksPath ~/.git-hooks
```

**Per-repo:**
```bash
cp githooks/commit-msg .git/hooks/
chmod +x .git/hooks/commit-msg
```

The hook:
- Removes Claude attribution lines from commits
- Enforces [Conventional Commits](https://www.conventionalcommits.org/) format

## Cross-Platform Notes

| File | macOS/Linux | Windows |
|------|-------------|---------|
| `CLAUDE.md` | `~/.claude/CLAUDE.md` | `%USERPROFILE%\.claude\CLAUDE.md` |
| `settings.json` | `~/.claude/settings.json` | `%USERPROFILE%\.claude\settings.json` |
| Git hooks | `~/.git-hooks/` | `%USERPROFILE%\.git-hooks\` (runs via Git Bash) |

Claude also reads `CLAUDE.md` from parent directories and repo roots, merging them with global settings. Add `CLAUDE.md` to `.gitignore` if it contains personal config not meant for the team.
