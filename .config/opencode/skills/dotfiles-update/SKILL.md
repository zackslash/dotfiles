---
name: dotfiles-update
description: Safely commit and optionally push changes to the ~/.dotfiles bare git repo
---

# Skill: dotfiles-update

## Purpose

Commit changes in the `~/.dotfiles` bare git repo (work-tree: `$HOME`) after scanning for sensitive information, then offer to push.

The dotfiles repo is a **bare repo**: all git commands must use:
```
git --git-dir="$HOME/.dotfiles" --work-tree="$HOME"
```

## Workflow

### Step 1: Check for staged/unstaged changes

Run:
```bash
git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" status
```

If there is **nothing to commit**, tell the user and stop.

### Step 2: Show the full diff

Run:
```bash
git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" diff HEAD
```

If there are staged changes, also run:
```bash
git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" diff --cached
```

Display the complete diff output to the user so they can review it.

### Step 3: Sensitive-information scan

Scan **every line of the diff** (both added `+` lines and context) for the following patterns. Flag any match as a **potential secret**:

| Category | Patterns to detect |
|---|---|
| Passwords / secrets | lines containing `password`, `passwd`, `secret`, `credentials` (case-insensitive) with a value assigned |
| API / auth tokens | strings matching `[A-Za-z0-9_\-]{20,}` after keywords like `token`, `api_key`, `apikey`, `access_key`, `auth` |
| Private keys | `-----BEGIN` (PEM headers), `PRIVATE KEY` |
| AWS credentials | `AKIA[0-9A-Z]{16}`, `aws_secret_access_key` |
| Generic high-entropy strings | base64 or hex blobs ≥ 40 chars on lines that look like assignments |
| Environment variable files | changes to `.env`, `.env.*`, `*.pem`, `*.key`, `id_rsa`, `id_ed25519` files |

If **any** potential secret is found:
1. List each flagged line with its file name and line number.
2. Warn the user clearly: **"⚠️ Potential sensitive data detected. Do not commit until reviewed."**
3. Ask the user what they want to do using the `question` tool:
   - **"Abort — I'll clean this up first"** → stop immediately, do not commit.
   - **"These are false positives — proceed anyway"** → continue to Step 4 with a note in the commit message.

If **no** sensitive data is found, tell the user "✅ No sensitive data detected." and continue.

### Step 4: Ask for a commit message

Ask the user:
> "What commit message would you like to use? (leave blank for a default)"

If the user provides a message, use it. If blank/empty, auto-generate a concise one based on the changed files — no conventional commit prefixes (no `chore:`, `feat:`, `fix:`, etc.), e.g.:
> `update <file1>, <file2>`

### Step 5: Stage and commit

Stage all changes that appear in `git status` (tracked files only — do NOT use `git add -u` on untracked files unless the user explicitly wants them):
```bash
git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" add -u
```

Then commit:
```bash
git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" commit -m "<message>"
```

Show the commit hash and summary to the user.

### Step 6: Show committed changes

Display a summary of what was committed:
```bash
git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" show --stat HEAD
```

### Step 7: Ask about pushing

Ask the user using the `question` tool:
> "Do you want to push these changes to the remote?"

Options:
- **"Yes, push now"** → run `git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" push` and show the result.
- **"No, keep local"** → acknowledge and stop.

## Error Handling

- If `~/.dotfiles` does not exist or is not a valid git repo, tell the user and stop.
- If `git add` or `git commit` fails, show the full error and stop — do not attempt to push.
- If `git push` fails (e.g. network error, rejected), show the full error and suggest the user check their remote configuration.

## Security Notes

- Never auto-commit if sensitive data is detected without explicit user confirmation.
- Never run `git add .` — only stage tracked files with `git add -u` to avoid accidentally staging untracked secrets.
- The scan in Step 3 is a best-effort heuristic; always remind the user that **they are responsible for reviewing the diff**.
