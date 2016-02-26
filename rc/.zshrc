# Path to the oh-my-zsh configuration
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="avit"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User specific aliases and functions
umask 002;

export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/mysql/bin:$PATH"

# Envs
export EDITOR="vim"
export VISUAL="vim"
export SVN_EDITOR="vim"

# Aliases
alias la="ls -al"
alias vi="vim"
alias view="vim -R"
alias src="source ~/.zshrc"
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Source device specific RC
if [ -f ~/.bash_device_rc ]; then
  . ~/.bash_device_rc
fi

# SSH Agent
SSH_ENV="$HOME/.ssh/environment"
function start_agent {
  echo "Initializing new SSH agent..."
  /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
  echo succeeded
  chmod 600 "${SSH_ENV}"
  . "${SSH_ENV}" > /dev/null
  /usr/bin/ssh-add;
}
# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
  . "${SSH_ENV}" > /dev/null
  ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
    start_agent;
  }
else
  start_agent;
fi

