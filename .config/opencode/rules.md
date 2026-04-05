# Global Rules

- Ask before installing packages, changing dependencies, or modifying lockfiles.
- Ask before starting long-running processes, development servers, watchers, or commands that open ports.
- Ask before running migrations, seed scripts, schema changes, or anything that mutates a database or external service.
- Do not read, print, move, or modify secrets unless explicitly requested. This includes `.env` files, credentials, tokens, and private keys.
- Keep changes scoped to the task. Ask before touching unrelated files or making opportunistic refactors.
- Avoid destructive operations unless explicitly requested. This includes force pushes, destructive git history changes, bulk cleanup, and irreversible deletions.
- Prefer inspection and dry-run steps before risky actions, and explain the intended command before running it when the impact is not obvious.
- Do not modify CI/CD configs, Dockerfiles, Makefiles, infrastructure-as-code files, or deployment manifests without explicit approval.
- Do not suppress or weaken security checks without explicit approval. This includes `#nosec`, `nolint`, `--no-verify`, `--insecure`, and `--skip-tls-verify` style changes.
- Never embed real secrets, tokens, keys, or credentials in source files, examples, tests, or fixtures. Use placeholders or environment variable references instead.
- Avoid compound shell commands when simpler alternatives exist. If a command uses chaining, pipes, or subshells, explain the full effect before running it.
- Do not transmit code, file contents, internal paths, security findings, or customer data to external URLs via web search or fetch. Use web access only to retrieve public documentation or reference material.
- When modifying authentication, authorization, cryptography, secrets handling, policy enforcement, sandboxing, input validation, or network exposure, call it out explicitly and explain the security impact before proceeding.
- Treat package installation (npm, pip, go get, cargo add, etc.) as a supply-chain event. Before installing a new dependency, confirm the package name, source registry, and version are correct and intentional.
- Running code directly (go run, python, node, ruby, npx) executes arbitrary logic. Apply the same scrutiny as any shell command, especially when the code handles cryptographic material, network connections, or external data.
- When working with security tooling — scanners, fuzzers, exploit harnesses, or CVE analysis — do not embed or display functional exploit payloads or private vulnerability details beyond what is necessary for the immediate task.
