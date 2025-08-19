# setxkbmap -option caps:escape_shifted_capslock
source $HOME/.profile_env

export ANDROID_HOME=/home/tobs/Android/Sdk
export VCPKG_ROOT=/home/tobs/.vcpkg
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$VCPKG_ROOT
export EDITOR="/home/tobs/.local/bin/nvim"

alias x="clear"
alias lg="lazygit"
alias g="git --no-pager"

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

e() {
  nvim $1
}

p() {
  if [[ -e "package-lock.json" ]]; then
    npm $@
  elif [[ -e "yarn.lock" ]]; then
    yarn $@
  elif [[ -e "bun.lockb" ]]; then
    bun $@
  else
    pnpm $@
  fi
}
. "$HOME/.cargo/env"
