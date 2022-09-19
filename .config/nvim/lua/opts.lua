--[[ opts.lua ]]
local opt = vim.opt
local g = vim.g
local cmd = vim.api.nvim_command

-- [[ Context ]]
opt.colorcolumn = '81'           -- str:  Show col for max line length
opt.cursorline = true            -- bool: highlight line the cursor is on
opt.number = true                -- bool: Show line numbers
opt.scrolloff = 5                -- int:  Min num lines of context
opt.signcolumn = "yes"           -- str:  Show the sign column

-- [[ Filetypes ]]
opt.encoding = 'utf8'            -- str:  String encoding to use
opt.fileencoding = 'utf8'        -- str:  File encoding to use

-- [[ Theme ]]
opt.syntax = "ON"                -- str:  Allow syntax highlighting
opt.termguicolors = true         -- bool: If term supports ui color then enable
opt.linebreak = true             -- bool: Break lines at word
opt.breakindent = true           -- bool: Indent breaked lines
opt.listchars='eol:¬,tab:▶-,trail:·,extends:>,precedes:<,nbsp:·'
vim.api.nvim_set_hl(0, 'ColorColumn' , {cterm=None, ctermbg=235})
vim.api.nvim_set_hl(0, 'CursorLine'  , {cterm=None, ctermbg=235})
vim.api.nvim_set_hl(0, 'Cursorcolumn', {cterm=None, ctermbg=235})
vim.api.nvim_set_hl(0, 'Cursor'      , {cterm=None, ctermbg=DarkGray})
--cmd('colorscheme ayu-mirage')    -- cmd:  Set the colorscheme
g.gruvbox_material_background = 'hard'
cmd('colorscheme gruvbox-material')-- cmd:  Set the colorscheme

-- [[ Search ]]
opt.ignorecase = true            -- bool: Ignore case in search patterns
opt.smartcase = true             -- bool: Override ignorecase if search contains capitals
opt.incsearch = true             -- bool: Use incremental search
opt.hlsearch = false             -- bool: Highlight search matches

-- [[ Whitespace ]]
opt.expandtab = true             -- bool: Use spaces instead of tabs
opt.shiftwidth = 3               -- num:  Size of an indent
opt.softtabstop = 3              -- num:  Number of spaces tabs count for in insert mode
opt.tabstop = 3                  -- num:  Number of spaces tabs count for

-- [[ Splits ]]
opt.splitright = true            -- bool: Place new window to right of current one
opt.splitbelow = true            -- bool: Place new window below the current one

-- [[ Undo ]]
opt.undolevels = 2000            -- num:  Number of undo levels
opt.undofile = true              -- bool: Save undo history between sessions
-- opt.undodir = "$XDG_DATA_HOME/nvim/undo//"

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
opt.completeopt = {'menuone', 'noselect', 'noinsert'}
opt.shortmess = opt.shortmess + { c = true }
vim.api.nvim_set_option('updatetime', 300) 

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error 
-- Show inlay_hints more frequently 
vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])
