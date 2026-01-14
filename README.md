# Claude Code Starter Files

Starter templates for [Claude Code](https://platform.claude.com/docs/en/intro) configuration. Edit for your environment.

## Files & Philosophy

| File                     | Purpose                                                 | Location                           |
| ------------------------ | ------------------------------------------------------- | ---------------------------------- |
| `CLAUDE.md`              | Global dev environment config                           | `~/.claude/CLAUDE.md`              |
| `settings.json`          | Permission rules                                        | `~/.claude/settings.json`          |
| `git-platform-access.md` | GitHub/GitLab CLI setup guide                           | Reference doc                      |
| `githooks/commit-msg`    | Strips Claude taglines + validates conventional commits | `~/.git-hooks/`                    |
| `CLAUDE.md`              | Optional local project environment config               | `/path/to/local/project/CLAUDE.md` |

### Claude Code reads configuration in layers

| Layer   | Location                                          | Purpose                                 |
| ------- | ------------------------------------------------- | --------------------------------------- |
| Global  | `~/.claude/CLAUDE.md` & `~/.claude/settings.json` | Personal preferences, security baseline |
| Project | `CLAUDE.md` at project root                       | Team/project conventions                |

**Global CLAUDE.md** - global dev environment, tooling preferences, security rules. Set once.

**Project CLAUDE.md** - project-specific commands, architecture, constraints. Version controlled.

Settings merge: Local project `CLAUDE.md` overrides global `CLAUDE.md` settings if duplicated, otherwise concatenated together.

## Global Settings Setup

### 1. CLAUDE.md (Global)

Copy to `~/.claude/CLAUDE.md` and customize:
- Global dev environment details
- Framework/tooling preferences
- Git workflow conventions

### 2. settings.json

Copy to `~/.claude/settings.json`. Permission syntax: `Tool(pattern)`

| Rule                         | Meaning                |
| ---------------------------- | ---------------------- |
| `Bash(git add:*)`            | Allow with any args    |
| `Bash(npm run lint)`         | Exact command only     |
| `Read(**/.env)`              | Match in any directory |
| `WebFetch(domain:npmjs.org)` | Specific domain        |

**Categories:**
- `allow` - Auto-approved (no prompt)
- `ask` - Requires confirmation
- `deny` - Blocked entirely
- `additionalDirectories` - Directories Claude can access

### 3. Git Hook

**Global (all projects):**
```bash
mkdir -p ~/.git-hooks
cp githooks/commit-msg ~/.git-hooks/
chmod +x ~/.git-hooks/commit-msg
git config --global core.hooksPath ~/.git-hooks
```

The hook:
- Removes Claude attribution lines from commits
- Enforces [Conventional Commits](https://www.conventionalcommits.org/) format

## Local Project Settings Setup

Run `/init` in your project to create a project `CLAUDE.md`:

```bash
claude
> /init
```

This generates a new `CLAUDE.md` at project root with detected stack, scripts, tools, and structure. Commit it to share with your team. If `CLAUDE.md` already exists it will still do a scan and compare to the state of the local project files.

Customize by adding:
- **Commands** - dev server startup, format, test, lint shortcuts
- **Architecture** - key patterns, file structure
- **Constraints** - security rules, accessibility requirements

## Cross-Platform Notes for config & tool locations

| File            | macOS/Linux                           | Windows                                           |
| --------------- | ------------------------------------- | ------------------------------------------------- |
| `CLAUDE.md`     | `~/.claude/CLAUDE.md`                 | `%USERPROFILE%\.claude\CLAUDE.md`                 |
| `settings.json` | `~/.claude/settings.json`             | `%USERPROFILE%\.claude\settings.json`             |
| `ccusage.md`    | `~/.claude/commands/ccusage.md`       | `%USERPROFILE%\.claude\commands\ccusage.md`       |
| `SKILL.md`      | `~/.claude/skills/review-pr/SKILL.md` | `%USERPROFILE%\.claude\skills\review-pr\SKILL.md` |
| `commit-msg`    | `~/.git-hooks/commit-msg`             | `%USERPROFILE%\.git-hooks\` (runs via Git Bash)   |
