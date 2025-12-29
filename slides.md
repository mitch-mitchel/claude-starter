# Claude Gems: Daily Dev Life Hacks

## Built-In (Zero Setup)

| Gem | What it does |
|-----|--------------|
| **Shift + Tab** | Accept suggestions, keep flow going |
| **ESC + ESC** | Bail out anytime, interrupt safely |
| **Slash commands** | `/help`, `/init`, `/clear`, `/compact` |
| **`claude --continue`** | Resume your last session |
| **`claude --resume`** | Pick from recent sessions |

---

## Light Setup Required

| Gem | What it does | Setup |
|-----|--------------|-------|
| **ccusage** | Check API costs at a glance | `npm i -g ccusage` ([third-party package](https://github.com/ryoppippi/ccusage)) |
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
