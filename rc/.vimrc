set nocompatible

" Theme/Colors
set t_Co=256
syntax enable

set encoding=utf-8

" Vim UI
set number
set cul

" Text Formatting
set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab
set smartindent
set smarttab
set nowrap


" filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'https://github.com/gmarik/Vundle.vim'       " Let Vundle manage itself
Plugin 'https://github.com/scrooloose/nerdtree'     " Tree Display for file system
Plugin 'airblade/vim-gitgutter'                     " Git diff gutter
" Plugin 'valloric/youcompleteme'
call vundle#end()


" NERDTree

let g:NERDTreeDirArrows=0

" Open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close vim if NERDTree is the only open buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

