# create a directory and cd into it
function mkd {
  mkdir -p "$@" && cd "$_"
}

# determine size of a file or total size of a directory
function fs {
  if du -b /dev/null > /dev/null 2>&1; then
    local arg=-sbh
  else
    local arg=-sh
  fi
  if [[ -n "$@" ]]; then
    du $arg -- "$@"
  else
    du $arg .[^.]* ./*
  fi
}

# start a PHP server from a directory, optional port
function server {
  local port="${1:-4000}"
  local ip=$(localip)
  sleep 1 && open "http://${ip}:${port}/" &
  php -S "${ip}:${port}"
}

# usefil dig output
function digg {
  dig +nocmd "$1" any +multiline +noall +answer
}

# fast & simple vim
function v {
  if [ $# -eq 0 ]; then
    vim .
  else
    vim "$@"
  fi
}

# fast & simple open
function o {
  if [ $# -eq 0 ]; then
    open .
  else
    open "$@"
  fi
}


########
# Fun
########

# screen recording to gif
# > gifit source.mov dest.gif
function gifit {
  ffmpeg -i "$1" -filter:v scale=1200:-1 -pix_fmt rgb32 -r 25 -f gif - | gifsicle --optimize=3 --delay=3 > "$2"
}

# live update the CPU temp
function cputemp {
  while true;
  do
    # buffer the output before refreshing the screen to avoid flickering delays
    out=$(iStats | head -n 7)
    clear
    echo $out
    sleep 5
  done
}

# live update git tree
function gittree {
  while true;
  do
    clear
    git log \
      --graph \
      --all \
      --color \
      --date=short \
      -40 \
      --pretty=format:"%C(yellow)%h%x20%C(white)%cd%C(green)%d%C(reset)%x20%s%x20%C(bold)(%an)%Creset" |
    cat -
    sleep 10
  done
}

# live twitter feed
function twitter {
  while true;
  do
    # buffer the output before refreshing the screen to avoid flickering delays
    out=$(t list timeline inspiring-people -n 8)
    clear
    echo $out
    sleep 60
  done
}
