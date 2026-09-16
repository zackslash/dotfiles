#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
export PATH=$PATH:~/scripts
export PATH=$PATH:~/go/bin

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/luke/.lmstudio/bin"
# End of LM Studio CLI section
#

export PATH="$HOME/.local/bin:$PATH"

# Update tmux pane title with pwd (tmux propagates to Ghostty via set-titles)
if [[ "$TERM_PROGRAM" == "ghostty" ]] || [[ -n "$TMUX" ]]; then
  PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND;} printf \"\033]2;%s\007\" \"\$(pwd)\""
fi

# Auto-start tmux on interactive shell
if command -v tmux &>/dev/null && [ -z "$TMUX" ]; then
  exec tmux new-session
fi

# Fast TUI startup (still honored by opencode v2): skip palette query and loading screen
export OTUI_PALETTE_IDLE_TIMEOUT_MS=1
export OPENCODE_FAST_BOOT=1
# opencode v2: no wrapper needed - every client attaches to the shared
# background service automatically (tmux panes/windows all share it).

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Load secrets (not tracked in dotfiles)
[ -f ~/.secrets ] && source ~/.secrets

alias whipper='PYTHONWARNINGS="ignore::UserWarning" whipper'

alias vi="nvim"
alias vim="nvim"

# Open directories in Cosmic Files (macOS-style 'open' command)
open() {
  cosmic-files "${1:-.}" &>/dev/null &
  disown
}
