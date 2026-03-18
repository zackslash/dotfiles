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

## Tracked files

| File | Description |
|---|---|
| `~/.bashrc`, `~/.bash_profile` | Bash shell config |
| `~/.gitconfig` | Git config |
| `~/.tmux.conf`, `~/.config/tmux/` | Tmux config |
| `~/.config/nvim/` | Neovim (LazyVim) config |
| `~/.config/opencode/` | opencode config and skills |
| `~/.config/git/ignore` | Global gitignore |
| `~/.config/htop/htoprc` | htop config |
| `~/.config/autostart/` | Autostart desktop entries |
| `~/.config/whipper/whipper.conf` | Whipper CD ripper config |
| `~/scripts/` | Personal shell scripts |
