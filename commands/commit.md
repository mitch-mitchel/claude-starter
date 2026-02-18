Create well-organized git commits for all staged and unstaged changes. NEVER push.

## Process

1. Run `git status` and `git diff` to understand all changes
2. Group related changes into logical commits (by feature, fix, or concern)
3. For each group:
   - Stage the relevant files with `git add <files>`
   - Commit with conventional commit format: `type(scope?): description`
   - Valid types: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert
4. Show summary of commits created

## Rules

- Keep commits atomic - one logical change per commit
- Write clear, concise commit messages (imperative mood)
- Include scope when it adds clarity (e.g., `feat(chat):`, `fix(docker):`)
- NEVER run `git push` - only stage and commit locally
- If unsure how to group changes, ask the user

## Example output

```
Created 3 commits:
a1b2c3d feat(auth): add login endpoint
d4e5f6g fix(api): handle null response
g7h8i9j docs: update README with setup instructions
```
