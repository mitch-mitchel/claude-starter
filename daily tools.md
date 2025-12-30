# Claude Daily Shortcuts & Commands

## Built-In (Zero Setup)

| Shortcut                | What it does                                  |
| ----------------------- | --------------------------------------------- |
| **Shift + Tab**         | Toggle modes - Normal, Planning, Accept Edits |
| **ESC + ESC**           | Bail out anytime, interrupt safely            |
| **Slash commands**      | `/help`, `/init`, `/clear`, `/compact`        |
| **`claude --continue`** | Resume your last session, `-c`  alias         |
| **`claude --resume`**   | Pick from recent sessions, `-r` alias         |

---

## Light Setup Required

| Tool        | What it does                | Setup                                                                            |
| ----------- | --------------------------- | -------------------------------------------------------------------------------- |
| **ccusage** | Check API costs at a glance | `npm i -g ccusage` ([third-party package](https://github.com/ryoppippi/ccusage)) |

  See simple `./commands/ccusage.md` config to create `/ccusage` custom slash command
---

## Philosophy (No Setup, Just Habits)

- **Trust but verify** - Claude makes mistakes, review outputs - have Claude review itself!
- **Git init everything** - Even local-only projects; recovery insurance
- **Default permissions** - Reading/searching OK, writing asks first or flat out deny

---

## Settings.json Quick Example

```json
{
  "permissions": {
    "allow": ["Bash(git commit:*)", "Bash(git diff:*)"],
    "deny": ["Bash(git push:*)", "Read(**/.env)"]
  }
}
```
