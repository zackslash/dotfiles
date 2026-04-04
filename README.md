# dotfiles

Personal dotfiles managed via a bare git repo, based on the [Atlassian method](https://www.atlassian.com/git/tutorials/dotfiles).

## Setup on a new machine

```bash
git clone --bare https://github.com/zackslash/dotfiles.git $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout
```

> If checkout fails due to conflicts, back up or remove the conflicting files and run again.

## Usage

```bash
dotfiles add ~/.some_config
dotfiles commit -m "update some_config"
dotfiles push
```

## Required tools

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

### Key bindings

#### Debugging (Go)

| Key | Action |
|-----|--------|
| `F5` | Continue |
| `F6` | Step over |
| `F7` | Step into |
| `F8` | Step out |
| `F9` | Toggle breakpoint |
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |
| `<leader>dc` | Continue |
| `<leader>dn` | Step over |
| `<leader>di` | Step into |
| `<leader>do` | Step out |
| `<leader>dq` | Terminate session |
| `<leader>du` | Toggle DAP UI |
| `<leader>dr` | Open REPL |
| `<leader>dt` | Debug nearest Go test |
| `<leader>dT` | Re-run last Go test |

#### Testing (Go)

| Key | Action |
|-----|--------|
| `<leader>tt` | Run nearest test |
| `<leader>tT` | Run test file |
| `<leader>ts` | Run test suite |
| `<leader>tl` | Re-run last test |
| `<leader>to` | Show test output |
| `<leader>tO` | Toggle output panel |
| `<leader>tp` | Toggle test summary |

#### Git

| Key | Action |
|-----|--------|
| `<leader>gd` | Open diffview |
| `<leader>gh` | File history |
| `<leader>gH` | Branch history |
| `<leader>gD` | Close diffview |

#### opencode

| Key | Action |
|-----|--------|
| `<C-.>` | Toggle opencode panel |
| `<C-a>` | Ask opencode (current file context) |
| `<C-x>` | Execute opencode action picker |
| `go` | Add range/selection to opencode |
| `goo` | Add current line to opencode |
| `<S-C-u>` | Scroll opencode up |
| `<S-C-d>` | Scroll opencode down |

#### Copilot (inline completions)

| Key | Action |
|-----|--------|
| `Tab` | Accept suggestion |
| `<C-Right>` | Accept next word |
| `<C-Down>` | Accept whole line |
| `<Alt-]>` | Next suggestion |
| `<Alt-[>` | Previous suggestion |
| `<C-]>` | Dismiss suggestion |

#### General

| Key | Action |
|-----|--------|
| `<leader>cf` | Format file |
| `<leader>um` | Toggle markdown rendering |

## Tracked files

| File | Description |
|---|---|
| `~/.bashrc`, `~/.bash_profile` | Bash shell config |
| `~/.gitconfig` | Git config |
| `~/.tmux.conf`, `~/.config/tmux/` | Tmux config |
| `~/.config/nvim/` | Neovim (LazyVim) config |
| `~/.config/ghostty/` | Ghostty terminal config |
| `~/.config/opencode/` | opencode config and skills |
| `~/.config/git/ignore` | Global gitignore |
| `~/.config/htop/htoprc` | htop config |
| `~/.config/autostart/` | Autostart desktop entries |
| `~/.config/whipper/whipper.conf` | Whipper CD ripper config |
| `~/scripts/` | Personal shell scripts |

## Tips

- Run `dotfiles status` to see pending changes across your home directory.
- Use `dotfiles diff` before committing to review what changed.
- To list all tracked files: `dotfiles ls-files`
- On a fresh machine, set up the alias before running checkout: without it the `dotfiles` command won't be available.
