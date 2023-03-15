# Default programs
export BROWSER="firefox"
export TERMINAL="kitty"
export EDITOR="nvim"
export MANPAGER='nvim +Man!'
export VISUAL="nvim"

export PATH=$HOME/.cargo/bin:$HOME/.local/bin::/usr/local/go/bin:$PATH

# Cleanup home
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOMR="$HOME/.config"
export ZDOTDIR="$HOME/.config/zsh"
export INPUTRC="$HOME/.config/inputrc"
export ZSH_CACHE_DIR="$HOME/.cache/zsh"
export LESSHISTFILE="-"

# Vim color scheme
export VIM_COLORSCHEME="sonokai"
export NEOVIDE_MULTIGRID=true

mkdir -p "$ZSH_CACHE_DIR/completions"

# rustup update > /dev/null 
source "/home/tei/dev/emsdk/emsdk_env.sh"
