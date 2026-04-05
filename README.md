# dotfiles

Personal dotfiles managed as a bare Git repo using the [Atlassian method](https://www.atlassian.com/git/tutorials/dotfiles).

## Bootstrap on a new machine

```bash
git clone --bare https://github.com/zackslash/dotfiles.git "$HOME/.dotfiles"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout
```

If checkout reports conflicts, move or back up the conflicting files and run it again.

## Daily usage

```bash
dotfiles status
dotfiles diff
dotfiles add ~/.some_config
dotfiles commit -m "update some_config"
dotfiles push
```

New files must be added explicitly. Updates to already tracked files can be reviewed with `dotfiles status` and `dotfiles diff`.

## Tooling

| Tool | Purpose |
|------|---------|
| [Neovim](https://neovim.io/) (v0.10+) | Editor |
| [tmux](https://github.com/tmux/tmux) | Terminal multiplexer (auto-started by `.bashrc`) |
| [TPM](https://github.com/tmux-plugins/tpm) | Tmux plugin manager — `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`, then `prefix + I` to install plugins |
| [opencode](https://opencode.ai/) | AI coding assistant (terminal) |
| [Go](https://go.dev/) (1.21+) | Go toolchain |
| [delve](https://github.com/go-delve/delve) | Go debugger — `go install github.com/go-delve/delve/cmd/dlv@latest` |
| [GitHub Copilot](https://github.com/features/copilot) | AI completions (subscription required) — run `:Copilot auth` after first Neovim launch |
| [Ghostty](https://ghostty.org/) | Terminal emulator |
| [yay](https://github.com/Jguer/yay) | AUR helper (Arch Linux) |
| [flatpak](https://flatpak.org/) | Flatpak package manager |

## Neovim

Uses [LazyVim](https://www.lazyvim.org/) + [lazy.nvim](https://github.com/folke/lazy.nvim). Plugins install automatically on first launch.

### Plugins

| Plugin | Purpose |
|--------|---------|
| `Mofiqul/vscode.nvim` | VS Code dark theme |
| `zbirenbaum/copilot.lua` | Inline AI completions |
| `sindrets/diffview.nvim` | Side-by-side git diffs |
| `lewis6991/gitsigns.nvim` | Inline git blame |
| `MeanderingProgrammer/render-markdown.nvim` | Rendered markdown in buffer |
| `mfussenegger/nvim-dap` + `rcarriga/nvim-dap-ui` | Debug adapter protocol |
| `leoluz/nvim-dap-go` | Go debug via delve |
| `nvim-neotest/neotest` + `fredrikaverpil/neotest-golang` | Go test runner |
| `nickjvandyke/opencode.nvim` | opencode integration |
