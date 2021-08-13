set encoding=UTF-8 nobomb	" Set encodig
set nocompatible		" be iMproved, required
set wildmenu			" Better command-line completion
set completeopt=longest,menu	" Setting for wildmenu
set autoindent			" Autoindent line
set number			" Display line-number
set clipboard=unnamed		" Use the OS clipboard
set noerrorbells		" Disable error beeps
set nostartofline		" Don't reset the cursor
set title			" Show filename in titlebar
set display+=lastline		" Always try yo display paragraph last line
set autoread			" Re-read files if unmodified inside Vim
set confirm			" Display confirm dialog when close unsaved file
set wrap			" wrap long line
set visualbell			" Use visualbell instead of 'beep' when doing something wrong
set lazyredraw			" Don't redraw while executing macros
set autochdir			" auto change work directory
set ttimeoutlen=0               " toggle between modes almost instantly
set numberwidth=3		" How many column to use for the line number
set showmode			" Show current mode

" status line
set statusline=
set statusline+=%f\ %2*%m\ %1*%h
set statusline+=%#warningmsg#
set statusline+=%*
set statusline+=%r%=[%{&encoding}\ %{&fileformat}\ %{strlen(&ft)?&ft:'none'}]\ %12.(%c:%l/%L%)

" Show absolute line numbers in insert mode, relative line numbers otherwise
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

" Centralize backups, swapfiles and undo history
set backupdir=/etc/vim/backups
set directory=/etc/vim/swaps

if exists("&undodir")
	set undodir=/etc/vim/undo
endif

filetype off			" required
syntax on			" enable syntax higlight

" Enable use of the mouse for all modes
if has('mouse')
  set mouse=a
endif

"Return to last edit position when opening files
autocmd BufReadPost *
    \ if line("'\"") >=1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g'\""
    \ | endif

" set the runtime path to include Vundle and initialize
set rtp+=/etc/vim/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Completor
Plugin 'maralla/completor.vim'

" NERDTree
Plugin 'preservim/nerdtree'

" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

"NERDTree devicons
Plugin 'ryanoasis/vim-devicons'

"Higlight filename
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'

" Whenever cursor jumps some distance or moves between windows, it will flash so you can see where it is.
Plugin 'danilamihailov/beacon.nvim'

"C support
Plugin 'WolfgangMehner/c-support'

"Enable C suppport
let  g:C_UseTool_cmake    = 'yes'
let  g:C_UseTool_doxygen = 'yes'

" .csv file support
Plugin 'chrisbra/csv.vim'

" PHP Support
"Plugin 'phpvim/phpcd.vim'
Plugin 'tobyS/pdv'

" Autocolosing brackets
Plugin 'Raimondi/delimitMate'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
