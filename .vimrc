execute pathogen#infect()
map <leader>s :source ~/.vimrc<CR>
set number

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
   au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
   filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd                     " Show (partial) command in status line.
set showmatch                   " Show matching brackets.
set ignorecase                  " Do case insensitive matching
set smartcase                   " Do smart case matching
set shiftwidth=3	        " Number of auto-indent spaces
set softtabstop=3	        " Number of spaces per Tab
"set incsearch		        " Incremental search
"set autowrite		        " Automatically save before commands like :next and :make
set hidden                      " Hide buffers when they are abandoned
set linebreak                   " Break lines at word
" set mouse=a                   " Enable mouse usage (all modes)
set splitright                  " open vsplits to the right

set undolevels=1000             " Number of undo levels
set undofile                    " Maintain undo history between sessions
set undodir=~/.vim/undodir

set history=100

"" lightline config
"set laststatus=2
"let g:lightline = {
"   \ 'colorscheme': 'jellybeans',
"   \ }
"set noshowmode

set laststatus=2
"hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15

function! DefaultStatusLineColor()
   " Focused statusline
   "hi statusline   guibg=DarkGrey ctermfg=30 guifg=White ctermbg=47
   hi statuslineNC guibg=DarkGrey ctermfg=DarkGray guifg=White ctermbg=8
   " Unfocused statusline
   hi statusline   guibg=DarkGrey ctermfg=8 guifg=White ctermbg=DarkGray
endfunction

function! InsertStatuslineColor(mode)
   if a:mode == 'i'
      hi statusline guibg=Cyan ctermfg=DarkYellow  guifg=Black ctermbg=LightGray
   elseif a:mode == 'r'
      hi statusline guibg=Purple ctermfg=5 guifg=Black ctermbg=0
   else
      hi statusline guibg=DarkRed ctermfg=1 guifg=Black ctermbg=0
   endif
endfunction

call DefaultStatusLineColor() 

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * call DefaultStatusLineColor() 

hi CursorLine   cterm=NONE ctermbg=8
hi CursorColumn cterm=NONE ctermbg=8
hi Cursor       cterm=NONE ctermbg=DarkGray
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

" default the statusline to green
" when entering Vim
" hi statusline guibg=DarkGrey
" ctermfg=8 guifg=White ctermbg=15

set statusline=\ %f\ [%t]%m%r%h\ %y%=line:\ %4l/%L,\ col:%2v\ \ %3p%%\  
" https://stackoverflow.com/a/4390122

" whitespace chars
set listchars=eol:¬,tab:▶-,trail:·,extends:>,precedes:<,nbsp:·
nnoremap <space> :set list!<CR>

" Ctrl-n toggle NERDtree
map <C-n> :NERDTreeToggle<CR>

" Open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()
