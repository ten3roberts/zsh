HISTFILE=$HOME/.config/zsh/.history
HISTSIZE=1000
SAVEHIST=1000

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Ignore duplicate entries in history
setopt autopushd pushdignoredups hist_ignore_all_dups prompt_subst autocd

# ### CHANGE TITLE OF TERMINALS
# function chpwd {
#   case ${TERM} in
#     xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|alacritty|st*|konsole*)
#       echo -ne "\033]0;zsh ${PWD/#$HOME/~}\007"
#       ;;
#     screen*)
#       echo -ne "\033_zsh ${PWD/#$HOME/\~}\033\\"
#       ;;
#   esac
# }

# chpwd


# # Git
# git_prompt() {
#   changes=`git status --porcelain | wc -l` > /dev/null 2>/dev/null
#   # untracked=`git clean -n | wc -l` > /dev/null 2>/dev/null

#   ref=$(git symbolic-ref HEAD | cut -d'/' -f3) > /dev/null 2>/dev/null
#   [ -n "$ref" ] && echo -n " %F{3}$ref%F{white}"
#   # [ "$untracked" != "0" ] && echo -n "+"
#   [ "$changes" != "0" ] && echo -n "•"
# }

# # Configure Shell state
# # PS1='%F{green}%n@%F{red}%m%F{white} %F{blue}%3~%F{white}$(git_prompt)%(?.%F{white}.%F{red} [%?])%(!.#.>)%F{white} '
# PS1='%F{green}%n@%F{red}%m %F{blue}%3~$(git_prompt)%(?.%F{white}.%B%F{red} [%?]%b)%(!.#.>)%F{white} '

# Install the pure prompt
ZPUREDIR="$HOME/.config/zsh/pure"
[ -d "$ZPUREDIR" ] || git clone https://github.com/sindresorhus/pure.git "$ZPUREDIR"
fpath+="$ZPUREDIR"
autoload -U promptinit; promptinit
prompt pure

# Helper functions
mkcd() { mkdir -p "$@" && cd "$1" }
# Quick movement aliases
# alias d='cd `find -maxdepth 3 -type d | fzf` && exa'
# alias n='cd `find -maxdepth 3 | fzf` && nvim .'

n() {
  res=`rg --files | fzf --tiebreak=index`
  [ -z $res ] && return 1
  [ -d $res ] && (cd $res; nvim .)
  [ -f $res ] && (cd `dirname $res`; nvim `basename $res`)
}

### ARCHIVE EXTRACTION
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

### Aliases ###

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# Changing "ls" to "exa"
if type exa >/dev/null; then
  alias ls='exa -F --group-directories-first' # my preferred listing
  alias la='exa -Fa --group-directories-first'  # all files and dirs
  alias ll='exa -l --git --header --group-directories-first'  # long format
  alias lt='exa -TL 2 --group-directories-first' # tree listing
  alias l='exa -F --group-directories-first'
  alias l.='exa -a | egrep "^\."'
else
  echo "exa not found, defaulting to ls"
fi

if [[ "$TERM" == "xterm-kitty" ]]; then
  alias ssh='TERM="xterm-256color" ssh'
fi

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias igrep='grep --color=auto -i'
alias ig='igrep'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
# alias z='zoxide'

alias -g G='| igrep '

# Verbose copy and remove
alias cp="cp -vi"
alias mv='mv -vi'
alias rm='rm'

# Rust cargo
alias cb='cargo build'
alias cr='cargo run'
alias ct='cargo test'
alias clippy='cargo clean && cargo clippy'
alias cw='cargo watch -c'
alias cwr='cargo watch -cx run'
alias cargo-bump='cargo workspaces version'
cto() { cargo test $@ -- --nocapture }

alias nv='nvim'

# Git aliases
alias log='git log --oneline'
alias ggraph='git log --graph --all --abbrev-commit'
alias subupdate='git submodule foreach git pull origin master'
alias status='git status'
alias branch='git checkout'

alias g='git'
alias gc='git commit'
alias ga='git add -v'
alias gp='git push'
alias gl='git log --oneline'
alias gpl='git pull'
alias gs='git status'
alias gd='git diff'
alias gb='git branch'
alias gds='git diff --stat'

# Void linux aliases
alias xi='sudo xbps-install'
alias xq='xbps-query'
alias xr='sudo xbps-remove'

alias hc='herbstclient'

alias killbg='kill ${${(v)jobstates##*:*:}%=*}'

alias pipes='pipes.sh -t `shuf -i 0-9 -n 1` -R -p 2 -f 20'

### Plugins ###

export KEYTIMEOUT=1
# Basic emacs keybindings
bindkey -e

# Bind Ctrl+x to open CLI edit in $EDITOR
autoload edit-command-line
zle -N edit-command-line
bindkey '^x' edit-command-line

# Ctrl Arrow key navigation
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Fix delete key
bindkey "^[[3~" delete-char
# Fix Ctrl backspace
bindkey "^H" backward-kill-word

# Control key navigation
bindkey '\e[1;5C' forward-word            # C-Right
bindkey '\e[1;5D' backward-word           # C-Left

# Basic auto/tab complete:
autoload -U compinit
zmodload zsh/complist
zstyle ':completion:*' menu select

fpath+="${ZDOTDIR}/.zsh_functions"
# zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Load syntax highlighting
source $HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source $HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Enable rust
source $HOME/.config/zsh/rust.zsh

# Fzf

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(zoxide init zsh)"

return 0
