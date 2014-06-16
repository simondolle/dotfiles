set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'

Bundle 'scrooloose/syntastic'

Bundle 'Valloric/YouCompleteMe'

Plugin 'bling/vim-airline'

Bundle 'kien/ctrlp.vim'

Bundle 'scrooloose/nerdtree'

Bundle "Shougo/unite.vim"

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" do not force to save when switching buffer
set hidden

" replace tabs with spaces
:retab

" line wrapping
set textwidth=0 
set wrapmargin=0
" set nowrap

autocmd vimenter * NERDTree ~/src
let NERDTreeIgnore = ['\.pyc$']

" highlight trailing white spaces
" found on http://stackoverflow.com/questions/356126/how-can-you-automatically-remove-trailing-whitespace-in-vim
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Remove trailing spaces on save
autocmd BufWritePre *.py :%s/\s\+$//e

" coding style
set colorcolumn=80
syntax on
filetype indent plugin on
" set modeline

"execute pathogen#infect()
" color scheme
syntax enable
set background=dark
colorscheme solarized

" status line appears all the time
set laststatus=2

" set working directory to current dir
cabbr <expr> %% expand('%:p:h')

" ctags
" tip from http://benoithamelin.tumblr.com/post/15101202004/using-vim-exuberant-ctags-easy-source-navigation
" to deal with multiple ctags files
" vim looks in the current directory for a tag file, then in its parent and
" so on recursively until it reaches "~/src"
set tags=./tags;~/src

" update ctags on save (inspired from 
" http://benoithamelin.tumblr.com/post/15101202004/using-vim-exuberant-ctags-easy-source-navigation
function! UpdateTags()
  let filename = expand("%:p")
  let cmd = 'ctags-proj.sh ' . filename
  let resp = system(cmd)
endfunction
autocmd BufWritePost *.py call UpdateTags()
