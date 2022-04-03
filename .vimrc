set nocompatible "required vundle
filetype off "required vundle
"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle manages itself with this line
Plugin 'VundleVim/Vundle.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'junegunn/goyo.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'flazz/vim-colorschemes'
Plugin 'kchmck/vim-coffee-script'
"Plugin 'vim-syntastic/syntastic'
" Vundle plugins must be added before this line
call vundle#end()
filetype plugin indent on

" make NERDTree open everytime automatically
autocmd vimenter * NERDTree
autocmd VimEnter * wincmd w " open on other window
"if NERDTRee is the only open window in vim close out
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" syntastic plugin commands
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" start Goyo without bottom bar by typing \yo
map <Leader>yo :Goyo <bar> highlight StatusLineNC ctermfg=white <CR>

" stuff from the engr server
set cindent
set sw=3
set number relativenumber
set mouse=a

syntax on
set showmatch
set showmode
filetype on

