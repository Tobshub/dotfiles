setxkbmap -option caps:escape_shifted_capslock

source $HOME/.profile_env

. "$HOME/.cargo/env"

# export QT_QPA_PLATFORM="wayland"
# export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"

export FLYCTL_INSTALL="/home/tobs/.fly"
export PATH="$FLYCTL_INSTALL/bin:$HOME/go/bin:$HOME/bin:$HOME/.local/bin:$HOME/.cargo/env:/usr/local/bin:/usr/local/go/bin:$PATH"

export EDITOR="/home/tobs/.local/bin/nvim"

export GOPROXY="proxy.golang.org"

alias docker="sudo docker"
alias x="clear"
alias lg="lazygit"
alias g="git"

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

e() {
  lvim $1
}

p() {
  if [[ -e "package.json" ]]; then
    npm $1
  elif [[ -e "yarn.lock" ]]; then
    yarn $1
  else
    pnpm $1
  fi
}
