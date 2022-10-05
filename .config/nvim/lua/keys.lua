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

vim.keymap.set('n', '<C-s>', function()
  vim.o.spell = not vim.o.spell
  print('spell: ' .. (vim.o.spell and 'on' or 'off'))
end)

-- [[ tab management ]]
map('n', '<Tab><Tab>'  , ':tabnew<cr>'    , {noremap = true}) 
map('n', '<Tab><up>'   , ':+tabmove<cr>'  , {noremap = true}) 
map('n', '<Tab><down>' , ':-tabmove<cr>'  , {noremap = true}) 
map('n', '<Tab><left>' , ':tabp<cr>'      , {noremap = true}) 
map('n', '<Tab><right>', ':tabn<cr>'      , {noremap = true}) 

map('n', '<C-h>'       , ':noh<cr>' , {noremap = true})

-- Toggle plugins
map('n', '<C-n>'    , [[:NvimTreeToggle<cr>]]       , {})
map('n', '<leader>l', [[:IndentBlanklineToggle<cr>]], {})
map('n', '<leader>t', [[:TagbarToggle<cr>]]         , {})

-- Telescope
map('n', 'ff'       , [[:Telescope find_files hidden=true<cr>]], {noremap = true})
map('n', 'fb'       , [[:Telescope buffers<cr>]]    , {noremap = true})
map('n', 'fc'       , [[:Telescope colorscheme<cr>]], {noremap = true})
map('n', 'fh'       , [[:Telescope help_tags<cr>]]  , {noremap = true})
map('n', 'fg'       , [[:Telescope live_grep<cr>]]  , {noremap = true})
map('n', 'fs'       , [[:Telescope grep_string<cr>]], {noremap = true})
map('n', 'fr'       , [[:Telescope registers<cr>]]  , {noremap = true})

