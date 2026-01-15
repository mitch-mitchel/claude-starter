# Global Dev Environment

Personal machine setup and universal preferences. Project-specific tooling belongs in each repo's `CLAUDE.md` (created via `/init`).

## Principles

1. Respect project conventions over personal preferences
2. DRY, YAGNI, Work → Right → Fast
3. Concise comments and documentation

## Git Workflow

- **Commit format:** Conventional Commits (`type(scope?): description`)
- **Valid types:** feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert
- **Multi-line commits:** Use multiple `-m` flags (heredocs blocked by sandbox)
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

Keep templates/components simple. Move complex logic (multiple conditionals, string building, accessibility wiring) into components, computed properties, or backend.

## Python & Django

- **Imports:** Top-level only. Local imports only to resolve circular dependencies.
- **Templates:** Named endblocks (`{% endblock content %}` not `{% endblock %}`), lowercase form methods (`method="post"`).

## Claude Code Behavior

**Skills & Hooks:**
- Default to global (`~/.claude/`), ask before creating
- Project instructions go in repo's `CLAUDE.md`, not local `.claude/`
- Local `.claude/` only for team-shared skills to commit

**When commands are blocked:**
- Before write/delete outside cwd → ask user to run manually upfront
- After sandbox failure → ask user to run manually (don't search for workarounds)
- Offer to document in appropriate CLAUDE.md for future sessions

**`gh` CLI sandbox issues:**
1. Don't autonomously use `dangerouslyDisableSandbox`
2. Ask first with options: retry with sandbox disabled, user runs manually, or workaround
3. Workarounds: `gh api --cache`, local git refs, ask user for output

## Environment Context

| Path | Purpose | Remote |
|------|---------|--------|
| `~/projects/` | Personal/consulting | GitLab |
| `~/flp/` | FLP work/Open source | GitHub |
| `~/projects/dotfiles/` | Mac environment backup | - |

Git uses `includeIf` for directory-based email switching (`~/.gitconfig-flp`).

**Tools:** VS Code, Homebrew, oh-my-zsh + iTerm2, fnm (Node), venv (Python)
