#!/bin/bash

# requirements
reqs="zsh git"

# dotfiles directory
dir=~/dotfiles

# old dotfiles directory
olddir=~/dotfiles_old

# files to move into ~/
files="vimrc zshrc oh-my-zsh"

# stop on errors
set -e

# ensure requirements exist
for req in $reqs; do
  if ! [ $(which "$req") ]; then
    echo "$req could not be found"
    exit
  fi
done


# install oh-my-zsh 
if [[ ! -d $dir/oh-my-zsh ]]; then
  git clone https://github.com/robbyrussell/oh-my-zsh
fi


# create backup directory
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"


# link dotfiles
echo "Changing into the $dir directory ..."
cd $dir

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
