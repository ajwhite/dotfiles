set nocompatible

" Theme/Colors
set t_Co=256
syntax enable

set encoding=utf-8

" Vim UI
set number                                          " Show line numbers
set laststatus=2                                    " Always display the status line
set noshowmode                                      " Hide default mode indicator (powerline instead)

" Text Formatting
set tabstop=2                                        " A tab is 2 spaces
set expandtab                                        " Use spaces instead of tabs
set shiftwidth=2                                     " Number of spaces for autoindenting
set smartindent                                      " Smartly indent
set smarttab                                         " Smartly indent
set autoindent
set list listchars=tab:»·,trail:·,nbsp:·             " Display extra whitespace
filetype indent on                                   " Enable smart indents

" Disable annoying beep
set visualbell

" Respond to keys faster - fix for powerline
set timeoutlen=1000 ttimeoutlen=0

" Disable vim backups
set nobackup
set noswapfile

" Enable wildmenu
set wildmenu
set wildmode=list:longest,full

" Enable mouse (shuttup, I like it)
set ttyfast
set mouse=a

" Default split locations
set splitright
set splitbelow

""""""""""""""""
" PLUGINS
"""""""""""""""""

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'https://github.com/gmarik/Vundle.vim'       " Let Vundle manage itself
Plugin 'scrooloose/nerdtree'                        " Tree Display for file system
Plugin 'airblade/vim-gitgutter'                     " Git diff gutter
Plugin 'kien/ctrlp.vim'                             " Fuzzy find files
Plugin 'vim-airline/vim-airline'                    " Better status bar
Plugin 'vim-airline/vim-airline-themes'             " Status bar themes
Plugin 'jiangmiao/auto-pairs'                       " Automatically pair braces, etc
Plugin 'tpope/vim-fugitive'                         " Git support
Plugin 'tpope/vim-surround'                         " Surround selections with characters
Plugin 'pangloss/vim-javascript'                    " JS syntax and indent plugins
Plugin 'haya14busa/incsearch.vim'                   " Better searching
Plugin 'haya14busa/incsearch-fuzzy.vim'             " Better searching w/ fuzzyfind
Plugin 'majutsushi/tagbar'                          " Tagbar
Plugin 'scrooloose/syntastic'                       " Syntax helpers
Plugin 'ternjs/tern_for_vim'                        " Support for Javascript autocomplete
if v:version > 703
  Plugin 'valloric/youcompleteme'                   " Autocomplete support
  " IMPORTANT INSTALLATION NOTES
  " https://github.com/Valloric/YouCompleteMe#installation
  " cd ~/.vim/bundle/you-complete-me
  " ./install.py --tern-completer
endif
" Plugin 'valloric/youcompleteme'
call vundle#end()
filetype on

"""""""""""""""""""
" KEYMAPS
"""""""""""""""""""
" Remap leader from \ to space
nnoremap <SPACE> <Nop>
let mapleader=" "

" Quick safe close
nnoremap <leader>q :q<CR>
" Quick force close
nnoremap <leader>Q :q!<CR>
" Quick save
nnoremap <leader>s :w<CR>
" Open CtrlP
map <C-p> :CtrlP<CR>
" Reload file
nmap <S-r> :e!<CR>

" Disable line deleting functions.
map K <Nop>
map J <Nop>
map s <Nop>

" Disable annoying unused keys
map Q <Nop>

" Tab mappings
nmap <C-t> :tabnew<CR>
nmap <S-t> :tabclose<CR>
nmap <S-Tab> :tabnext<CR>

" Paging mapping
nmap <S-d> <C-d>
nmap <S-u> <C-u>

" Searching
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
nnoremap <Esc><Esc> :nohlsearch<CR>

" Fuzzy searching
map f/ <Plug>(incsearch-fuzzy-/)
map f? <Plug>(incsearch-fuzzy-?)
map fg/ <Plug>(incsearch-fuzzy-stay)

" Makes the current vsplit window wider by 10 characters
map <leader><Right> 10<C-W>>
" Makes the current vsplit window smaller by 10 characters
map <leader><Left> 10<C-W><
" Makes the current hsplit window taller by 10 characters
map <leader><Up> 10<C-W>+
" Makes the current hsplit window shorter by 10 characters
map <leader><Down> 10<C-W>-

" Center matched search terms
map N Nzz
map n nzz

" Search selected text
vnoremap / "hy/<C-r>h"

" Toggle NERDTree
map <C-n> :NERDTreeToggle<CR>
" Toggle TagBar
map <S-t> :TagbarToggle<CR>



"""""""""""""""
" Folding
"""""""""""""""

" Fold with Shift-F
map <S-f> za

" Don't fold by default
set nofoldenable

" Fold background color
hi Folded ctermbg=235

" Fold logic
function! JSfold()
  let line = getline(v:lnum)
  if match(line, '^\s*function') > -1
    return ">1"
  elseif match(line, '^.*function\s*(.*') > -1
    return "a1"
  elseif match(line, '^\s*\(if\|for\)\s*(.*') > -1
    return ">2"
  else
    return "="
  endif
endfunction
autocmd FileType javascript setlocal foldmethod=expr foldexpr=JSfold()



"""""""""""""""
" Autocomplete
"""""""""""""""
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS


"""""""""""""""
" NERDTree
"""""""""""""""

" Use ASCII characters for directory arrows
let g:NERDTreeDirArrows=0

" Open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close vim if NERDTree is the only open buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"""""""""""""""
" CtrlP
"""""""""""""""
if (1 == executable('ack'))
  " if `ack` is installed, use it as the CtrpP indexer
  let g:ctrlp_user_command = 'ack -i --noenv --nocolor --nogroup -f %s'
endif


"""""""""""""""
" TagBar
"""""""""""""""

" Set ctags executable for JS
let g:tagbar_type_javascript = {
  \ 'ctagsbin': '$NVM_BIN/jsctags'
\ }


"""""""""""""""
" Syntastic
"""""""""""""""

" Use eslint over jshint
let g:syntastic_javascript_checkers = ['eslint']


"""""""""""""""
" Airline
"""""""""""""""
let g:airline_theme='laederon'        " Sets the theme
let g:airline_powerline_fonts=1       " Use patched font for icon support
