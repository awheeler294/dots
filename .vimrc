" Autoload vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
   silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

map <leader>s :source ~/.vimrc<CR>
set number relativenumber 

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

if has("autocmd")
   "  jump to the last position when reopening a file
   au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
   " load indentation rules and plugins according to the detected filetype.
   filetype plugin indent on
   " start in insert mode for new files
   autocmd BufNewFile * startinsert
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd                    " Show (partial) command in status line.
set showmatch                   " Show matching brackets.
set ignorecase                  " Do case insensitive matching
set smartcase                   " Do smart case matching
set shiftwidth=3	        " Number of auto-indent spaces
set softtabstop=3	        " Number of spaces per Tab
set tabstop=3
set expandtab
"set incsearch		        " Incremental search
"set autowrite		        " Automatically save before commands like :next and :make
set hidden                      " Hide buffers when they are abandoned
set linebreak                   " Break lines at word
" set mouse=a                   " Enable mouse usage (all modes)
set splitright                  " open vsplits to the right
set wildmenu                    " visual autocomplete for command menu
set incsearch                   " search as characters are entered

set undolevels=1000             " Number of undo levels
set undofile                    " Maintain undo history between sessions
set undodir=~/.vim/undodir

set history=100
set eventignore=CursorMoved

set laststatus=2
set scrolloff=20                " Number of lines to ofset scrolling

function! DefaultStatusLineColor()
   " Focused statusline
   hi statusline   ctermfg=12  ctermbg=235
   " Unfocused statusline
   hi statuslineNC ctermfg=235 ctermbg=12
endfunction

function! InsertStatuslineColor(mode)
   if a:mode == 'i'
      hi statusline ctermfg=13 ctermbg=235
   elseif a:mode == 'r'
      hi statusline ctermfg=202 ctermbg=235
   else
      hi statusline ctermfg=1  ctermbg=0
   endif
endfunction

call DefaultStatusLineColor() 

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * call DefaultStatusLineColor() 

hi ColorColumn ctermbg=235
hi CursorLine   cterm=NONE ctermbg=235
hi CursorColumn cterm=NONE ctermbg=235
hi Cursor       cterm=NONE ctermbg=DarkGray
set colorcolumn=81
set cursorline
nnoremap H :set cursorcolumn!<CR>

" hi LineNr ctermbg=DarkGray
" set foldcolumn=2
hi foldcolumn ctermbg=8
hi VertSplit ctermbg=8 ctermfg=0

highlight DiffAdd    cterm=bold ctermfg=4   ctermbg=238 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=88  ctermbg=236 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=106 ctermbg=238 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=17  ctermbg=94  gui=none guifg=bg guibg=Red

hi MatchParen cterm=bold ctermbg=none ctermfg=135
set noshowmatch

" default the statusline to green
" when entering Vim
" hi statusline guibg=DarkGrey
" ctermfg=8 guifg=White ctermbg=15

set statusline=\ %f\ [%t]%m%r%h\ %y%=line:\ %4l/%L,\ col:%2v\ \ %3p%%\ %{LineNoIndicator()} 
" https://stackoverflow.com/a/4390122

" whitespace chars
set listchars=eol:¬,tab:▶-,trail:·,extends:>,precedes:<,nbsp:·
nnoremap <space> :set list!<CR>

" tab managment
nnoremap <Tab><up>    :tabr<cr>
nnoremap <Tab><down>  :tabl<cr>
nnoremap <Tab><left>  :tabp<cr>
nnoremap <Tab><right> :tabn<cr>
nnoremap <Tab><Tab>   :tabnew<cr>

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'python-mode/python-mode'
Plug 'mhinz/vim-startify'
Plug 'drzel/vim-line-no-indicator'
Plug 'lilydjwg/colorizer'
Plug 'guns/xterm-color-table.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
call plug#end()

" Ctrl-n toggle NERDtree
map <C-n> :NERDTreeToggle<CR>

" Open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Startify | NERDTree | endif

" Open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()

"let g:colorizer_auto_color = 1

set nofoldenable


