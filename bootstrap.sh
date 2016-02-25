#!/bin/bash

# requirements
reqs="zsh git"

# dotfiles directory
dir=~/dotfiles

# old dotfiles directory
olddir=~/dotfiles_old

# files to move into ~/
files="rc/vimrc rc/zshrc oh-my-zsh"

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

  if [ -f $dest ] || [ -d $dest ]; then
    echo "$dest already exists, moving to $olddir"
    mv $dest $olddir
  fi

  ln -s $source $dest
}

for filename in "${configurationFiles[@]}"; do
  baseName=$(basename "$filename")
  symlink $dir/$filename $HOME/$baseName
done

exit

for file in $files; do
  if [ -f ~/.$file ] || [ -d ~/.$file ]; then
    echo "$file found in home directory, moving into backup directory"
    mv ~/.$file $olddir
  fi
  echo "Creating symlink for $file"
  ln -s $dir/$file ~/.$file
done

# enter ZSH shell
if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
  chsh -s $(which zsh)
fi
