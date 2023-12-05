setxkbmap -option caps:escape

source $HOME/.profile_env

. "$HOME/.cargo/env"

export FLYCTL_INSTALL="/home/tobs/.fly"
export PATH="$FLYCTL_INSTALL/bin:$HOME/go/bin:$HOME/bin:$HOME/.local/bin:$HOME/.cargo/env:/usr/local/bin:/usr/local/go/bin:$PATH"

export EDITOR="/home/tobs/.local/bin/nvim"

export GOPROXY="proxy.golang.org"

alias p="pnpm"
alias vim="lvim ."
alias docker="sudo docker"
alias x="clear"
alias lg="lazygit"
alias g="git"

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
