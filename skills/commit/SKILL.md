---
name: commit
description: Create well-organized git commits for all staged and unstaged changes. NEVER push.
allowed-tools: Bash, Glob, Grep, Read
---

# Git Commit

Create well-organized git commits for all staged and unstaged changes. NEVER push.

## Process

1. **Run lint/format first** using this priority:

   a. **Local CLAUDE.md** - Check for `pre-commit-command:` in repo's CLAUDE.md
      ```markdown
      pre-commit-command: make lint
      ```

   b. **Task runners** - Check for and use if available:
      - `make lint` or `make format` (check Makefile for targets)
      - `npm run lint` or `npm run format` (check package.json scripts)
      - `yarn lint` / `pnpm lint`

   c. **Pre-commit** - If `.pre-commit-config.yaml` exists:
      ```bash
      pre-commit run --all-files
      ```

   d. **Direct tools** (fallback) - Run if config exists:
      | Config file | Command |
      |-------------|---------|
      | `pyproject.toml` with ruff | `ruff check --fix . && ruff format .` |
      | `.eslintrc*` or `eslint.config.*` | `npx eslint --fix .` |
      | `.prettierrc*` or `prettier.config.*` | `npx prettier --write .` |
      | `.djlintrc` or pyproject with djlint | `djlint --reformat .` |
      | `biome.json` | `npx biome check --apply .` |

2. **Stage any auto-fixed files** before proceeding

3. **Understand all changes**
   - Run `git status` (never use `-uall` flag)
   - Run `git diff` to understand modifications

4. **Group related changes** into logical commits (by feature, fix, or concern)

5. **For each group:**
   - Stage the relevant files with `git add <files>`
   - Commit with conventional commit format: `type(scope?): description`
   - Valid types: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert

6. **Show summary** of commits created

## Rules

- Keep commits atomic - one logical change per commit
- Write clear, concise commit messages (imperative mood)
- Include scope when it adds clarity (e.g., `feat(chat):`, `fix(docker):`)
- NEVER run `git push` - only stage and commit locally
- If unsure how to group changes, ask the user
- If lint/format fails after auto-fix, re-stage and retry

## Known issues

**macOS sandbox noise**: You may see errors like `zsh:1: operation not permitted: /tmp/claude-501/cwd-*`. These are harmless - commands still execute correctly. This is a known Claude Code bug (see GitHub issues #22109, #21654). Ignore these warnings.

## Example output

```
Created 3 commits:
a1b2c3d feat(auth): add login endpoint
d4e5f6g fix(api): handle null response
g7h8i9j docs: update README with setup instructions
```
