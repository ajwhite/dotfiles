# Path to the oh-my-zsh configuration
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="avit"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User specific aliases and functions
umask 002;

# Envs
export EDITOR="vim"
export VISUAL="vim"
export SVN_EDITOR="vim"

# Aliases
alias la="ls -al"
alias vi="vim"
alias view="vim -R"
alias src="source ~/.zshrc"

# Source device specific RC
if [ -f ~/.bash_device_rc ]; then
  . ~/.bash_device_rc
fi
