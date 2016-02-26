#!/bin/bash

# requirements
reqs="zsh git"

# dotfiles directory
dir=~/dotfiles

# old dotfiles directory
olddir=~/dotfiles_old

# rc directory
configurationDir="rc"

# configuration files
configurationFiles=()

# stop on errors
set -e

############################
# ensure requirements exist
############################
for req in $reqs; do
  if ! [ $(which "$req") ]; then
    echo "$req could not be found"
    exit
  fi
done

#############################
# install oh-my-zsh 
#############################
if [[ ! -d $dir/oh-my-zsh ]]; then
  git clone https://github.com/robbyrussell/oh-my-zsh
fi


#############################
# gather all rc files
#############################

# allow * to match hidden files
shopt -s dotglob

for filename in $configurationDir/*; do
  configurationFiles+=($filename)
  echo "added $filename"
done

# undo * matching
shopt -u dotglob



###############################
# create backup directory
###############################
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

##############################
# link dotfiles
##############################
echo "Changing into the $dir directory ..."
cd $dir


function symlink() {
  local source=$1
  local dest=$2

  echo "symlinking $source to $dest"

  if [ -e $dest ]; then
    echo "$dest already exists, moving to $olddir"
    mv $dest $olddir
  fi

  ln -s $source $dest
}

for filename in "${configurationFiles[@]}"; do
  baseName=$(basename "$filename")
  symlink $dir/$filename $HOME/$baseName
done

# link oh-my-zsh
symlink $dir/oh-my-zsh $HOME/.oh-my-zsh

# enter ZSH shell
if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
  chsh -s $(which zsh)
fi
