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

Run a human-readable status:
```bash
git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" status
```

If there is **nothing to commit**, tell the user and stop.

**Snapshot the exact file list.** This is critical to prevent unrelated changes that appear later (e.g. editor lockfiles, auto-synced plugin versions) from being swept into the commit. Capture the set of tracked-modified files **now** by running:
```bash
git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" status --porcelain
```

Record every path that appears. This snapshot — call it the **staging set** — is the *only* set of files that may be committed in Step 5. Carry it forward through the rest of the workflow.

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

Before asking, auto-generate a concise commit message based on the changed files — no conventional commit prefixes (no `chore:`, `feat:`, `fix:`, etc.), e.g.:
> `update <file1>, <file2>`

Then ask the user using the `question` tool. The auto-generated option must show the actual generated message in the option label rather than a generic label like "Use default". For example:
- option label: `update opencode.json`
- option description: `Use the auto-generated message`

If the generated message is too long for the option label, use a shortened/truncated label that still shows the message and put the full generated message in the description.

If the user provides a custom message, use it. If they choose the auto-generated option or leave the message blank/empty, use the auto-generated message.

### Step 5: Stage and commit

**Stage only the files in the staging set captured in Step 1 — never blanket-stage.**

Do NOT use `git add -u`, `git add -A`, or `git add .`. These sweep in whatever is modified at commit time, which can include files that changed *after* the user reviewed the diff in Step 2 (e.g. `lazy-lock.json` plugin bumps, editor/session files, background tooling output). Instead, stage each path explicitly:
```bash
git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" add -- <path1> <path2> ...
```

**Drift guard (mandatory).** Right before staging, re-run `git status --porcelain` and compare against the staging set. If any **new** modified tracked file appears that was not in the original snapshot:
1. Stop and list the unexpected file(s) with a clear warning: **"⚠️ Files changed after review: <paths>. They were not part of the reviewed diff."**
2. Ask the user via the `question` tool whether to:
   - **"Exclude them — commit only the reviewed files"** → stage only the original staging set (default).
   - **"Include them too"** → re-run Step 2's diff for the new files, run Step 3's secret scan on them, then stage everything.
   - **"Abort"** → stop, commit nothing.

Only after resolving drift, commit:
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
- Never run `git add .`, `git add -A`, or `git add -u`. Always stage files by explicit path from the Step 1 staging set to avoid sweeping in unreviewed changes (and untracked secrets).
- The scan in Step 3 is a best-effort heuristic; always remind the user that **they are responsible for reviewing the diff**.
