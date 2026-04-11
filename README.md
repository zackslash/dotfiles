# dotfiles

Personal dotfiles managed as a bare Git repo using the [Atlassian method](https://www.atlassian.com/git/tutorials/dotfiles).

## Philosophy

This setup is meant to be:

- fast
- portable
- terminal-first
- recoverable on a fresh machine
- usable even if optional plugins or integrations are unavailable

Core workflow:

- **tmux** for long-lived sessions and pane/window management
- **Neovim / LazyVim** for editing
- **CLI tools** like `git`, `rg`, `fd`, and `lazygit` for specialized tasks

## Bootstrap on a new machine

```bash
git clone --bare https://github.com/zackslash/dotfiles.git "$HOME/.dotfiles"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout
```

If checkout reports conflicts, move or back up the conflicting files and run it again.

Persist the `dotfiles` alias in your shell config if you want to use it regularly.

## Daily usage

```bash
dotfiles status
dotfiles diff
dotfiles add ~/.some_config
dotfiles commit -m "update some_config"
dotfiles push
```

New files must be added explicitly. Updates to already tracked files can be reviewed with `dotfiles status` and `dotfiles diff`.

## Required tools

| Tool | Purpose |
|------|---------|
| [git](https://git-scm.com/) | Version control and bare dotfiles repo management |
| [tmux](https://github.com/tmux/tmux) | Terminal multiplexer (auto-started by `.bashrc`) |
| [Neovim](https://neovim.io/) | Editor |
| [ripgrep](https://github.com/BurntSushi/ripgrep) (`rg`) | Fast project text search |
| [fd](https://github.com/sharkdp/fd) | Fast file and directory search |

## Recommended tools

| Tool | Purpose |
|------|---------|
| [lazygit](https://github.com/jesseduffield/lazygit) | Terminal Git UI |
| [TPM](https://github.com/tmux-plugins/tpm) | Tmux plugin manager — `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`, then `prefix + I` to install plugins |
| [opencode](https://opencode.ai/) | AI coding assistant (terminal) |
| [Go](https://go.dev/) | Go toolchain |
| [delve](https://github.com/go-delve/delve) | Go debugger — `go install github.com/go-delve/delve/cmd/dlv@latest` |
| [GitHub Copilot](https://github.com/features/copilot) | AI completions (subscription required) — run `:Copilot auth` after first Neovim launch |
| [Ghostty](https://ghostty.org/) | Terminal emulator |
| [yay](https://github.com/Jguer/yay) | AUR helper (Arch Linux) |
| [flatpak](https://flatpak.org/) | Flatpak package manager |

## Neovim

Uses [LazyVim](https://www.lazyvim.org/) + [lazy.nvim](https://github.com/folke/lazy.nvim). Plugins install automatically on first launch.

Helpful boundary:

- **Neovim** provides the editor core
- **LazyVim** provides defaults, plugins, and keymaps
- **external tools** power many features under the hood

Common external tools used by the editor experience:

- `rg` for project text search
- `fd` for file finding
- `git` for repository operations
- `lazygit` for terminal Git workflow

## Recovery / fallback

If Neovim plugins fail or a machine is only partially bootstrapped, the core workflow should still work with:

- `tmux`
- plain `nvim`
- `git`
- `rg`
- shell tools

This repo is intended to stay productive even without every optional integration installed.
