--[[ keys.lua ]]
local map = vim.api.nvim_set_keymap

-- [[ whitespace management ]]
map('n', '<space>', ':set list!<cr>'  , {noremap = true})
map('n', 'H', ':set cursorcolumn!<cr>', {noremap = true})

-- [[ copy / paste ]]
map('n', '<leader>y', '"+y', {})
map('v', '<leader>y', '"+y', {})

map('n', '<leader>d', '"+d', {})
map('v', '<leader>d', '"+d', {})

map('n', '<leader>p', '"+p',        {})
map('v', '<leader>p', 'c<ESC>"+pa', {})
map('i', '<C-v>'    , '<ESC>"+pa' , {})

-- [[ tab management ]]
map('n', '<Tab><Tab>'  , ':tabnew<cr>', {noremap = true}) 
map('n', '<Tab><up>'   , ':tabr<cr>'  , {noremap = true}) 
map('n', '<Tab><down>' , ':tabl<cr>'  , {noremap = true}) 
map('n', '<Tab><left>' , ':tabp<cr>'  , {noremap = true}) 
map('n', '<Tab><right>', ':tabn<cr>'  , {noremap = true}) 

-- Toggle plugins
map('n', '<C-n>'    , ':NvimTreeToggle<cr>'         , {})
map('n', '<leader>l', [[:IndentLinesToggle<cr>]]    , {})
map('n', '<leader>t', [[:TagbarToggle<cr>]]         , {})

-- Telescope
map('n', 'ff'       , [[:Telescope find_files<cr>]] , {noremap = true})
map('n', 'fb'       , [[:Telescope buffers<cr>]]    , {noremap = true})
map('n', 'fc'       , [[:Telescope colorscheme<cr>]], {noremap = true})
map('n', 'fh'       , [[:Telescope help_tags<cr>]]  , {noremap = true})
map('n', 'fg'       , [[:Telescope live_grep<cr>]]  , {noremap = true})
map('n', 'fs'       , [[:Telescope grep_string<cr>]], {noremap = true})
map('n', 'fr'       , [[:Telescope registers<cr>]]  , {noremap = true})

-- FloaTerm configuration
map('n', "<leader>ft", ":FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2 fish <CR> ", {})
map('n', "t", ":FloatermToggle myfloat<CR>", {})
map('t', "<Esc>", "<C-\\><C-n>:q<CR>"      , {})
