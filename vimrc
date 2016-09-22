set nocompatible              " required
filetype on  " required
"set encoding=utf-8
set nu
let python_highlight_all=1
"let g:ycm_path_to_python_interpreter='/usr/bin/python2.7'
syntax on
" Enable foldin
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2
" au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
set foldmethod=indent
set foldlevel=99
"adding for folding with space"
nnoremap <space> za
let g:SimpylFold_docstring_preview=1
" python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
" Tab navigation like Firefox.
nnoremap <S-tab> :tabprevious<CR>
nnoremap <tab>   :tabnext<CR>
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Bundle 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
set clipboard=unnamed
if has('gui_running')
	set background=dark
	colorscheme solarized
else
	colorscheme desert
endif

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
" call togglebg#map("<F5>")
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
