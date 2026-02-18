# Global Dev Environment

Personal machine setup and universal preferences. Project-specific tooling belongs in each repo's `CLAUDE.md` (created via `/init`).

## Principles

1. Respect project conventions over personal preferences
2. DRY, YAGNI, Work → Right → Fast
3. Concise comments and documentation
4. **Never silence warnings** - Understand and fix root causes. Explain what the warning means, why it exists, and implement the correct solution. Code is a precision-based art form; suppressing warnings hides problems.

## Git Workflow

- **Commit format:** Conventional Commits (`type(scope?): description`)
- **Valid types:** feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert
- **Multi-line commits:** ALWAYS use multiple `-m` flags. NEVER use heredocs (sandbox blocks them).
  ```bash
  git commit -m "type: subject" -m "body line 1" -m "body line 2" -m "" -m "Co-Authored-By: ..."
  ```
- **Global hooks:** `~/.git-hooks/`

Run lint/format before committing. Pre-commit hooks auto-fix then abort, requiring re-stage.

## Post-Change Checklist

Quick mental check after code changes (don't overthink):

- **Tests:** If moved/renamed code and nothing broke, flag potential coverage gap
- **Docs:** Only update if public API or user-facing behavior changed

Skip for: typo fixes, style changes, internal refactors.

## Testing Philosophy

- **Test our code only** - Trust libraries/frameworks work. Don't test Django ORM, built-in decorators, third-party packages.
- **TDD-style** - Tests should fail if our code changes (e.g., changing "Sign in" to "Log in" should break the test).
- **Focus on:** Custom validation, business logic, custom methods, view responses, integration points.

## Presentation Layer

Templates should be dumb. Logic belongs in **models** or **JS**, not views or templates.

- Views: orchestration only (fetch data, call model methods, render)
- Templates: display only (loops, simple conditionals for show/hide)
- Models: business logic, computed properties, data transformation
- JS: client-side interactivity and state

## Python & Django

- **Imports:** Top-level only. Local imports only to resolve circular dependencies.
- **Templates:** Named endblocks (`{% endblock content %}` not `{% endblock %}`), lowercase form methods (`method="post"`).

## Claude Code Behavior

**Restart awareness:**
- After editing `~/.claude/settings.json`, `~/.claude/keybindings.json`, or any Claude Code config: **always remind user to restart Claude Code** (`/exit` + reopen) for changes to take effect. The running session uses the config it loaded at startup.

**Skills & Hooks:**
- Default to global (`~/.claude/`), ask before creating
- Project instructions go in repo's `CLAUDE.md`, not local `.claude/`
- Local `.claude/` only for team-shared skills to commit

**Project tooling:**
- Use `make` commands when available (lint, test, build) - they encapsulate best practices
- If sandbox blocks make commands, ask user to run them manually
- Don't bypass make with raw commands unless make isn't available

**When commands are blocked:**
- Before write/delete outside cwd → ask user to run manually upfront
- After sandbox failure → ask user to run manually (don't search for workarounds)
- Offer to document in appropriate CLAUDE.md for future sessions

**`gh` CLI:**
Go-based, hits macOS Seatbelt TLS errors in sandbox. `excludedCommands: ["gh"]` is set but broken upstream ([#10524](https://github.com/anthropics/claude-code/issues/10524)). When `gh` fails with TLS, let the sandbox escape hatch prompt — don't preemptively disable sandbox. Network domains pre-approved via `sandbox.network.allowedDomains`.

## Environment Context

| Path | Purpose | Remote |
|------|---------|--------|
| `~/projects/` | Personal/consulting | GitLab |
| `~/flp/` | FLP work/Open source | GitHub |
| `~/projects/dotfiles/` | Mac environment backup | - |

Git uses `includeIf` for directory-based email switching (`~/.gitconfig-flp`).

**Tools:** VS Code, Homebrew, oh-my-zsh + iTerm2, fnm (Node), venv (Python)

**Dotfiles (`~/projects/dotfiles/`):**
- Never manually copy files into the repo — `dotfiles.sh` is the only way files enter/leave
- **Never run `dotfiles.sh` yourself** — only the user runs backup/restore
- To add a new path: update `dotfiles.sh` (add to `FILES`, `CLAUDE_FILES`, or extend the hooks logic), then tell user to run `cd ~/projects/dotfiles && ./dotfiles.sh backup -y`
- `global-claude/` mirrors `~/.claude/` (settings.json, CLAUDE.md, hooks/)
