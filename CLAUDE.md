# Dev Environment

## Backup and Restore Repo
| `~/projects/dotfiles/` | Mac environment backup | - |

## Directory Structure & Git Identity
| Path | Purpose | Remote |
|------|---------|--------|
| `~/projects/` | (personal/consulting) | GitLab |
| `~/flp/` | Free Law Project + open source | GitHub |

Git uses `includeIf` for directory-based email switching.

## Environment
| Category | Tool |
|----------|------|
| IDE | VS Code (settings sync) |
| Package Manager | Homebrew (Apple Silicon, `/opt/homebrew/`) |
| Shell | oh-my-zsh (avit theme) + iTerm2 |
| Node Version Manager | fnm |
| Python Environments | venv |

## Preferred Frameworks
- **JavaScript:** SvelteKit
- **Python:** Django

## Preferred Tooling by Language

**Node.js/TypeScript:**
- Lint: `npm run lint` → ESLint
- Format: `npm run format` → Prettier
- Type check: `tsc --noEmit`
- Test: Vitest (unit), Playwright (e2e)
- Pre-commit: husky + lint-staged
- Pattern Library: Storybook

**Python/Django:**
- Lint: ruff check
- Format: ruff format
- HTML templates: djlint
- Type check: mypy
- Test: pytest
- Pre-commit: pre-commit
- Pattern Library: Custom with Atomic Design integration

## Git Workflow
- **Global hooks:** `~/.git-hooks/` (applies to all repos)
- **Commit format:** Conventional Commits (`type(scope?): description`)
- **Valid types:** feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert
- **Command execution:** Run git commands separately, not chained with `&&` or `;`

## Pre-Commit Workflow
Before committing, always run the repo's lint and format commands manually.

**Why:** Pre-commit hooks (husky, pre-commit) auto-fix files then abort the commit, requiring re-stage and retry. Running tools first ensures hooks are no-ops and commits succeed on the first attempt.

**Node/TS:** Check package.json scripts, typically:
- `npm run format && npm run lint --fix`

**Python:** Check pyproject.toml/ruff.toml, typically:
- `ruff format . && ruff check --fix`

Stage all changes after formatting, then commit.

## Principles
1. Native global configs preferred
2. Homebrew over macOS native (always)
3. Reuse and composition (DRY, YAGNI, Work -> Right -> Fast)
4. Concise comments or documentation