# Setup fzf
# ---------
if [[ ! "$PATH" == */home/timmer/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/timmer/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/timmer/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/timmer/.fzf/shell/key-bindings.zsh"
