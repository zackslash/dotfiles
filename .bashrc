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

# Auto-start tmux on interactive shell
if command -v tmux &>/dev/null && [ -z "$TMUX" ]; then
  exec tmux new-session
fi

# Port for opencode tmux support - auto-selects a free port per instance
opencode() {
  local port
  port=$(python3 -c "
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
  export OPENCODE_PORT=$port
  command opencode --port "$port" "$@"
}

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias whipper='PYTHONWARNINGS="ignore::UserWarning" whipper'

# Open directories in Cosmic Files (macOS-style 'open' command)
open() {
  cosmic-files "${1:-.}" &>/dev/null &
  disown
}
