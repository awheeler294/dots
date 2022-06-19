" Autoload vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
   silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

map <leader>s :source ~/.vimrc<CR>
set number 

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
set shiftwidth=3	              " Number of auto-indent spaces
set softtabstop=3	              " Number of spaces per Tab
set tabstop=3
set expandtab
"set incsearch		               " Incremental search
"set autowrite		               " Automatically save before commands like :next and :make
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

" reload when file changes on disk
" for tmux add 'set -g focus-events on' to .tmux.conf
set autoread
" trigger autoread when changing buffers inside while inside vim
au FocusGained,BufEnter * :checktime
"function! DefaultStatusLineColor()
"   " Focused statusline
"   hi statusline   ctermfg=12  ctermbg=235
"   " Unfocused statusline
"   hi statuslineNC ctermfg=235 ctermbg=12
"endfunction
"
"function! InsertStatuslineColor(mode)
"   if a:mode == 'i'
"      hi statusline ctermfg=13 ctermbg=235
"   elseif a:mode == 'r'
"      hi statusline ctermfg=202 ctermbg=235
"   else
"      hi statusline ctermfg=1  ctermbg=0
"   endif
"endfunction
"
"call DefaultStatusLineColor() 

"au InsertEnter * call InsertStatuslineColor(v:insertmode)
"au InsertLeave * call DefaultStatusLineColor() 

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

"set statusline=\ %f\ [%t]%m%r%h\ %y%=line:\ %4l/%L,\ col:%2v\ \ %3p%%\ %{LineNoIndicator()} 
" https://stackoverflow.com/a/4390122

" whitespace chars
set listchars=eol:¬,tab:▶-,trail:·,extends:>,precedes:<,nbsp:·
nnoremap <space> :set list!<CR>

" copy/paste keybindings
set pastetoggle=<F2>
nmap <leader>y "+y
vmap <leader>y "+y

vmap <leader>d "+d
nmap <leader>d "+d

nmap <leader>p "+p
vmap <leader>p c<ESC>"+p
imap <C-v> <ESC>"+pa

" tab managment
nnoremap <Tab><up>    :tabr<cr>
nnoremap <Tab><down>  :tabl<cr>
nnoremap <Tab><left>  :tabp<cr>
nnoremap <Tab><right> :tabn<cr>
nnoremap <Tab><Tab>   :tabnew<cr>

call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'preservim/nerdcommenter'
"Plug 'python-mode/python-mode'
Plug 'mhinz/vim-startify'
Plug 'drzel/vim-line-no-indicator'
Plug 'lilydjwg/colorizer'
Plug 'guns/xterm-color-table.vim'
Plug 'ctrlpvim/ctrlp.vim'
"Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'itchyny/lightline.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'itchyny/vim-gitbranch'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
Plug 'ron-rs/ron.vim'
call plug#end()

" coc config
let g:coc_global_extensions = ['coc-json', 'coc-tsserver', 'coc-html', 'coc-css', 'coc-java', 'coc-rls', 'coc-rust-analyzer', 'coc-yaml', 'coc-python', 'coc-go', 'coc-gitignore', 'coc-python', 'coc-pairs', 'coc-sh', 'coc-docker', 'coc-sql', 'coc-highlight']
set termguicolors

"let g:coc_node_args = ['--nolazy', '--inspect-brk=6045']

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" lightline config
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'ayu_mirage',
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }

let g:lightline.component = {
      \   'indicator': '%{LineNoIndicator()}',
      \   'cocstatus': '%{coc#status()}',
      \ }

let g:lightline.active = {
      \   'left': [
      \     [ 'mode', 'paste', ],
      \     [ 'relativepath', 'readonly', 'modified', ],
      \     [ 'cocstatus', ],
      \   ],
      \   'right': [
      \     [ 'indicator' ],
      \     [ 'lineinfo' ],
      \     [ 'gitbranch'],
      \   ]
      \ }

let g:lightline.inactive = {
      \   'left': [
      \     [ 'filename' , 'readonly', 'modified'],
      \   ],
      \   'right': [
      \     [ 'indicator' ],
      \     [ 'lineinfo' ],
      \   ],
      \ }

" ayu config
let ayucolor="mirage"
color ayu

" vim-line-no-indicator Config
let g:line_no_indicator_chars = ['⎺', '⎻', '─', '⎼', '⎽']

"NERCCommenter config
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" NERDtree config
" Ctrl-n toggle NERDtree
map <C-n> :NERDTreeToggle<CR>

" Open a NERDTree automatically when vim starts up if no files were specified
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Startify | NERDTree | endif

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Obsession | endif

" Open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()

"let g:colorizer_auto_color = 1
"let g:colorizer_hex_alpha_first = 1

" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" normal/insert
" example
nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
nmap <leader> m <Plug>MarkdownPreviewToggle

set nofoldenable

" This option creates & uses a 'default' session to be used in case when 
" launching vim and a corresponding session hasn't been found yet.
let g:prosession_default_session = 0
