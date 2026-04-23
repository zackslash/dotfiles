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

export PATH="$HOME/.local/bin:$PATH"

if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
  printf '\033]2;%s\007' "$(date '+%Y-%m-%d %H:%M:%S')"
fi

# Auto-start tmux on interactive shell
if command -v tmux &>/dev/null && [ -z "$TMUX" ]; then
  exec tmux new-session
fi

# Port for opencode tmux support - one shared port per tmux window
# All panes within the same window share the same OPENCODE_PORT
if [ -n "$TMUX" ]; then
  # Check if this window already has a port assigned (stored in tmux window env)
  _win_port=$(tmux show-environment -w OPENCODE_PORT 2>/dev/null | grep '^OPENCODE_PORT=' | cut -d= -f2)
  if [ -n "$_win_port" ]; then
    # Reuse the port already assigned to this window
    export OPENCODE_PORT=$_win_port
  else
    # Assign a new free port to this window and store it in the tmux window environment
    _win_port=$(python3 -c "
import socket
for p in range(4097, 4201):
    try:
        s = socket.socket()
        s.bind(('', p))
        s.close()
        print(p)
        break
    except OSError:
        pass
")
    export OPENCODE_PORT=$_win_port
    tmux set-environment -w OPENCODE_PORT "$_win_port" 2>/dev/null || tmux set-environment OPENCODE_PORT "$_win_port" 2>/dev/null
  fi
  unset _win_port
fi

opencode() {
  local port="${OPENCODE_PORT:-4097}"
  command opencode --port "$port" "$@"
}

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
