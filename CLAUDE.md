# Global Dev Environment

Personal machine setup and universal preferences.
Local project-specific tooling belongs in each repo's `CLAUDE.md` (created via `/init`).

## Backup and Restore Repo
| `~/projects/dotfiles/` | Mac environment backup | - |

## Directory Structure & Git Identity

| Path          | Purpose              | Remote |
| ------------- | -------------------- | ------ |
| `~/projects/` | Personal/consulting  | GitLab |
| `~/flp/`      | FLP work/Open source | GitHub |

Git `~/.gitconfig` uses `includeIf` for directory-based email switching set in `~/.gitconfig-flp`.

## Environment

| Category        | Tool                     |
| --------------- | ------------------------ |
| IDE             | VS Code (settings sync)  |
| Package Manager | Homebrew (Apple Silicon) |
| Shell           | oh-my-zsh + iTerm2       |
| Node            | fnm                      |
| Python          | venv                     |

## Git Workflow

- **Global hooks:** `~/.git-hooks/`
- **Commit format:** Conventional Commits (`type(scope?): description`)
- **Valid types:** feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert

## Pre-Commit Philosophy

Run the repo's lint/format commands before committing. Pre-commit hooks auto-fix then abort, requiring re-stage. Running tools first ensures hooks pass on first attempt.

## Principles

1. Respect project conventions over personal preferences
2. DRY, YAGNI, Work → Right → Fast
3. Concise comments and documentation
