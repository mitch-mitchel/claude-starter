# GitHub & GitLab CLI Access for Claude Code

Secure setup for `gh` (GitHub CLI) and `glab` (GitLab CLI) when used with Claude Code.

## Why This Matters

Claude Code executes CLI commands on your behalf. Proper authentication ensures:
- Claude can read PRs, issues, and repo metadata
- Write/destructive operations remain blocked by permission rules
- Credentials stay in your system keychain (never in conversation context)

## GitHub CLI (`gh`) Setup

### Authentication

```bash
# Interactive setup (recommended)
gh auth login --web --git-protocol ssh

# Verify
gh auth status
```

The browser OAuth flow is preferred—no tokens to manage or rotate.

### Token Scopes (if using PAT)

For fine-grained PAT, request minimal scopes:

| Scope                | Purpose             |
| -------------------- | ------------------- |
| `contents:read`      | Repository contents |
| `metadata:read`      | Repository metadata |
| `pull_requests:read` | PR access           |
| `issues:read`        | Issue access        |

For classic PAT: `repo` (private repos) + `read:org` (org access).

## GitLab CLI (`glab`) Setup

### Authentication

```bash
# Interactive setup
glab auth login --hostname gitlab.com

# For self-hosted GitLab
glab auth login --hostname gitlab.example.com

# Verify
glab auth status
```

### Token Scopes (if using PAT)

| Scope             | Purpose                     |
| ----------------- | --------------------------- |
| `read_api`        | Query projects, MRs, issues |
| `read_repository` | Repository contents         |
| `read_user`       | User profile info           |

**Avoid** the `api` scope (full read/write access).

## Permission Rules

Add these to your `settings.json`. The pattern: **allow read-only, deny destructive**.

### GitHub (`gh`)

```json
"allow": [
  "Bash(gh pr view:*)",
  "Bash(gh pr list:*)",
  "Bash(gh pr status:*)",
  "Bash(gh pr checks:*)",
  "Bash(gh pr diff:*)",
  "Bash(gh issue view:*)",
  "Bash(gh issue list:*)",
  "Bash(gh issue status:*)",
  "Bash(gh repo view:*)",
  "Bash(gh repo list:*)",
  "Bash(gh release view:*)",
  "Bash(gh release list:*)",
  "Bash(gh run view:*)",
  "Bash(gh run list:*)",
  "Bash(gh workflow view:*)",
  "Bash(gh workflow list:*)",
  "Bash(gh api:*)"
],
"deny": [
  "Bash(gh pr close:*)",
  "Bash(gh pr merge:*)",
  "Bash(gh pr lock:*)",
  "Bash(gh pr unlock:*)",
  "Bash(gh pr revert:*)",
  "Bash(gh issue close:*)",
  "Bash(gh issue delete:*)",
  "Bash(gh issue lock:*)",
  "Bash(gh issue unlock:*)",
  "Bash(gh issue transfer:*)",
  "Bash(gh repo delete:*)",
  "Bash(gh repo archive:*)",
  "Bash(gh repo unarchive:*)",
  "Bash(gh release delete:*)",
  "Bash(gh run cancel:*)",
  "Bash(gh run delete:*)"
]
```

### GitLab (`glab`)

```json
"allow": [
  "Bash(glab mr view:*)",
  "Bash(glab mr list:*)",
  "Bash(glab mr diff:*)",
  "Bash(glab issue view:*)",
  "Bash(glab issue list:*)",
  "Bash(glab repo view:*)",
  "Bash(glab ci view:*)",
  "Bash(glab ci list:*)",
  "Bash(glab api:*)"
],
"deny": [
  "Bash(glab mr close:*)",
  "Bash(glab mr merge:*)",
  "Bash(glab mr delete:*)",
  "Bash(glab issue close:*)",
  "Bash(glab issue delete:*)",
  "Bash(glab repo delete:*)",
  "Bash(glab ci cancel:*)",
  "Bash(glab ci delete:*)"
]
```

## Credential Security

### Do This

| Method                 | Platform | Notes                          |
| ---------------------- | -------- | ------------------------------ |
| System keychain        | macOS    | `osxkeychain` helper (default) |
| Git Credential Manager | Windows  | Bundled with Git for Windows   |
| libsecret / GCM        | Linux    | `apt install libsecret-1-0`    |

Both `gh` and `glab` store credentials securely by default when using the interactive login flow.

### Don't Do This

```bash
# NEVER put tokens in shell config
export GH_TOKEN="ghp_xxxxxxxxxxxx"      # in .bashrc/.zshrc
export GITLAB_TOKEN="glpat-xxxxx"       # in .profile

# NEVER commit tokens (even in .gitignore'd files)
echo "ghp_xxxxx" > .env
```

**Why shell config is dangerous:**
- Persists across sessions
- May sync to dotfiles repo
- Visible in shell history
- Accessible to any process reading environment

### Block Credential File Access

Already included in `settings.json` template:

```json
"deny": [
  "Read(~/.config/gh/hosts.yml)",
  "Read(~/.ssh/**)",
  "Read(**/*.pem)",
  "Read(**/*.key)"
]
```

## Sandbox Handling

The Claude Code sandbox may block `gh`/`glab` network requests.

**When commands fail with network errors:**

1. Claude should ask before disabling sandbox
2. Workarounds:
   - Use `gh api --cache` for repeated reads
   - Read PR/issue data from local git refs if already fetched
   - Run the command manually and paste output

**Document in your CLAUDE.md:**

```markdown
## Sandbox Configuration

When `gh` or `glab` fails with network errors:
1. Do NOT autonomously disable sandbox
2. Ask first, or request manual execution
```

## Cross-Platform Credential Helpers

```bash
# macOS (usually default)
git config --global credential.helper osxkeychain

# Windows (usually default with Git for Windows)
git config --global credential.helper manager

# Linux with libsecret
git config --global credential.helper /usr/lib/git-core/git-credential-libsecret

# Linux with Git Credential Manager
git config --global credential.helper /usr/bin/git-credential-manager
```

## Troubleshooting

| Symptom                     | Cause                         | Solution                               |
| --------------------------- | ----------------------------- | -------------------------------------- |
| `gh` returns 401            | Token expired/invalid         | `gh auth login`                        |
| `gh` hangs                  | Sandbox blocking network      | Ask user to run manually               |
| `glab` can't find config    | Wrong hostname                | Use `--hostname` explicitly            |
| Wrong email in commits      | Directory config not matching | Check `includeIf` path in `.gitconfig` |
| "Permission denied" on push | SSH key not in agent          | `ssh-add ~/.ssh/id_ed25519`            |

## SSH Setup Reference

For SSH key setup, see official docs:
- [GitHub: Generating SSH keys](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- [GitLab: SSH keys](https://docs.gitlab.com/ee/user/ssh.html)
