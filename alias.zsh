# shortcuts
alias g="git"
alias la="ls -al"
alias view="vim -R"
alias rbn="cd ~/Development/OneMightyRoar/Robin"
alias dev="cd ~/Development"
alias lab="cd ~/Development/Labs"
alias rooms="mux start rooms"
alias dashboard="mux start dashboard"
alias mysqlstart="sudo /usr/local/mysql/support-files/mysql.server start"
alias mysqlstop="sudo /usr/local/mysql/support-files/mysql.server stop"
alias apachestart="sudo apachectl start"
alias apachestop="sudo apachectl stop"
alias mongostart="mongod --config /usr/local/etc/mongod.conf"

# network
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# always use presets in babel REPL
alias babel-node="babel-node --presets es2015"

# toggle hidden files in Finder
alias showHiddenFiles='defaults write com.apple.finder AppleShowAllFiles Yes; killall Finder /System/Library/CoreServices/Finder.app'
alias hideHiddenFiles='defaults write com.apple.finder AppleShowAllFiles No; killall Finder /System/Library/CoreServices/Finder.app'

# use MacVim if available
if hash mvim 2>/dev/null; then
  alias vim="mvim -v"
  alias vi="mvim-v"
fi

# sniff network
alias sniff=sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'

# kill all chrome tabs
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

# lock the screen
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# reload the shell
alias reload="exec $SHELL -l"
alias src="source ~/.zshrc"
