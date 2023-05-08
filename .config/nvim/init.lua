

-- LEADER
-- These keybindings need to be defined before the first /
-- is called; otherwise, it will default to "\"
-- vim.g.mapleader = ","
-- vim.g.localleader = "\\"

-- IMPORTS
require('plug')      -- Plugins
require('vars')      -- Variables
require('opts')      -- Options
require('keys')      -- Keymaps

-- PLUGINS
require('impatient')

require('nvim-tree').setup{}

require('ayu').setup({
   mirage = true
})

require 'bubbly'

local tabby_theme = {
   -- fill = { fg = '#CBCCC6', bg = '#191E2A' },
   fill = 'TabLineFill',
   -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
   head = 'TabLine',
   current_tab = { fg = '#d9d7ce', bg = '#323A4C'},
   tab = 'TabLine',
   win = 'TabLine',
   tail = 'TabLine',
   hll = { fg = '#FFA759', bg = '#141925' },
   hlr = { fg = '#59c2ff', bg = '#141925' },
}

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

require('tabby.tabline').set(function(line)
   vim.o.showtabline = 1
   return {
      {
         { '  ', hl = tabby_theme.hll },
         line.sep('', tabby_theme.tail, tabby_theme.fill),

      },
      line.tabs().foreach(function(tab)
         -- print(dump(line.tabs()))
         -- print(dump(tab.number()))
         local hl = tab.is_current() and tabby_theme.current_tab or tabby_theme.tab

         local is_modified = false
         -- print(dump(vim.api.nvim_tabpage_list_wins(tab.number())))
         if vim.api.nvim_tabpage_is_valid(tab.number()) then
            for _, win in pairs(vim.api.nvim_tabpage_list_wins(tab.number())) do
               local buf = vim.api.nvim_win_get_buf(win)
               if vim.api.nvim_buf_get_option(buf, "modified") then
                  is_modified = true
                  break
               end
            end
         end

         return {
            line.sep('', hl, tabby_theme.fill),
            tab.is_current() and ' ' or ' ',
            tab.number(),
            tab.name(),
            is_modified and ' ' or '',
            line.sep('', hl, tabby_theme.fill),
            hl = hl,
            margin = ' ',
         }
      end),
      line.spacer(),
      {
         line.sep('', tabby_theme.tail, tabby_theme.fill),
         { '  ', hl = tabby_theme.hlr },
      },
      hl = tabby_theme.fill,
   } 
end, {
   buf_name = {
      mode = 'shorten'
   },
})

require('toggleterm').setup(
   (function()
      vim.o.hidden = true
      
      vim.api.nvim_set_keymap('n', "t"    , ":ToggleTerm<CR>"     , {noremap = true})

      vim.api.nvim_set_keymap('t', "<C-n>", "<C-\\><C-n>"         , {noremap = true})
      vim.api.nvim_set_keymap('t', "<Esc>", "<C-n>:ToggleTerm<CR>", {})
      
      return {
         open_mapping = '<C-t>',
         direction = 'float',
         float_opts = {
            border = 'curved',
         }
      }
   end)()
)

require('colorizer').setup({
   filetypes = { "*" },
      user_default_options = {
         RGB = true, -- #RGB hex codes
         RRGGBB = true, -- #RRGGBB hex codes
         names = true, -- "Name" codes like Blue or blue
         RRGGBBAA = true, -- #RRGGBBAA hex codes
         AARRGGBB = true, -- 0xAARRGGBB hex codes
         rgb_fn = false, -- CSS rgb() and rgba() functions
         hsl_fn = false, -- CSS hsl() and hsla() functions
         css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
         css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
         -- Available modes for `mode`: foreground, background,  virtualtext
         mode = "background", -- Set the display mode.
         -- Available methods are false / true / "normal" / "lsp" / "both"
         -- True is same as normal
         tailwind = false, -- Enable tailwind colors
         -- parsers can contain values used in |user_default_options|
         sass = { enable = false, parsers = { css }, }, -- Enable sass colors
         virtualtext = "■",
      },
      -- all the sub-options of filetypes apply to buftypes
      buftypes = {},
})

require('nvim-lastplace').setup{}

require('nvim-autopairs').setup{}

require('Comment').setup{
   ---Add a space b/w comment and the line
   padding = true,
   ---Whether the cursor should stay at its position
   sticky = true,
   ---Lines to be ignored while (un)comment
   ignore = nil,
   ---LHS of toggle mappings in NORMAL mode
   toggler = {
      ---Line-comment toggle keymap
      line = 'gcc',
      ---Block-comment toggle keymap
      block = 'gbc',
   },
   ---LHS of operator-pending mappings in NORMAL and VISUAL mode
   opleader = {
      ---Line-comment keymap
      line = 'gc',
      ---Block-comment keymap
      block = 'gb',
   },
   ---LHS of extra mappings
   extra = {
      ---Add comment on the line above
      above = 'gcO',
      ---Add comment on the line below
      below = 'gco',
      ---Add comment at the end of line
      eol = 'gcA',
   },
   ---Enable keybindings
   ---NOTE: If given `false` then the plugin won't create any mappings
   mappings = {
      ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
      basic = true,
      ---Extra mapping; `gco`, `gcO`, `gcA`
      extra = true,
      ---Extended mapping; `g>` `g<` `g>[count]{motion}` `g<[count]{motion}`
      extended = false,
   },
   ---Function to call before (un)comment
   pre_hook = nil,
   ---Function to call after (un)comment
   post_hook = nil,
}

require("mason").setup()

require('mason-tool-installer').setup {

  -- a list of all tools you want to ensure are installed upon
  -- start; they should be the names Mason uses for each tool
  ensure_installed = {

   'rust-analyzer',
   'codelldb',

   -- you can pin a tool to a particular version
   { 'golangci-lint', version = 'v1.47.0' },

   -- you can turn off/on auto_update per tool
   { 'bash-language-server', auto_update = true },

   'lua-language-server',
   'vim-language-server',
   'gopls',
   'stylua',
   'shellcheck',
   'editorconfig-checker',
   'gofumpt',
   'golines',
   'gomodifytags',
   'gotests',
   'impl',
   'json-to-struct',
   -- 'luacheck',
   'misspell',
   'revive',
   'shellcheck',
   'shfmt',
   'staticcheck',
   'vint',
  },

  -- if set to true this will check each tool for updates. If updates
  -- are available the tool will be updated. This setting does not
  -- affect :MasonToolsUpdate or :MasonToolsInstall.
  -- Default: false
  auto_update = true,

  -- automatically install / update on startup. If set to false nothing
  -- will happen on startup. You can use :MasonToolsInstall or
  -- :MasonToolsUpdate to install tools and check for updates.
  -- Default: true
  run_on_start = true,

  -- set a delay (in ms) before the installation starts. This is only
  -- effective if run_on_start is set to true.
  -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
  -- Default: 0
  start_delay = 3000, -- 3 second delay
}

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
   -- Enable completion triggered by <c-x><c-o>
   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

   -- Mappings.
   -- See `:help vim.lsp.*` for documentation on any of the below functions
   local bufopts = { noremap=true, silent=true, buffer=bufnr }
   vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
   vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
   vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
   vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
   vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
   vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
   vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
   vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
   end, bufopts)
   vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
   vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
   vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
   vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
   vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
   -- This is the default in Nvim 0.7+
   debounce_text_changes = 150,
}
require('lspconfig')['pyright'].setup{
   on_attach = on_attach,
   flags = lsp_flags,
}
require('lspconfig')['tsserver'].setup{
   on_attach = on_attach,
   flags = lsp_flags,
}
require('lspconfig')['rust_analyzer'].setup{
   on_attach = on_attach,
   flags = lsp_flags,
   -- Server-specific settings...
   settings = {
      ["rust-analyzer"] = {}
   }
}

local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

-- local rt = {
--    server = {
--       settings = {
--          -- on_attach = function(_, bufnr)
--          --    -- Hover actions
--          --    vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
--          --    -- Code action groups
--          --    vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
--          --    require 'illuminate'.on_attach(client)
--          -- end,
--          ["rust-analyzer"] = {
--             checkOnSave = {
--                command = "clippy"
--             }, 
--          },
--       }
--    },
-- }
-- require('rust-tools').setup(rt)

-- Completion Plugin Setup
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 },        -- source current buffer
    { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
    { name = 'calc'},                               -- source for math calculation
    { name = 'spell' },                             -- source for spelling
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              path = '🖫',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
})

-- Treesitter Plugin Setup 
require('nvim-treesitter.configs').setup {
   ensure_installed = { 
      "bash",
      "c",
      "clojure",
      "cmake",
      "cpp",
      "css",
      "d",
      "dart",
      "dockerfile",
      "erlang",
      "fish",
      "gitignore",
      "go",
      "haskell",
      "html",
      "http",
      "java",
      "javascript",
      "json",
      "json5",
      "jsonc",
      "julia",
      "kotlin",
      "latex",
      "llvm",
      "lua",
      "make",
      "markdown",
      "nix",
      "perl",
      "php",
      "python",
      "racket",
      "regex",
      "ruby",
      "rust",
      "scala",
      "scheme",
      "sql",
      "swift",
      "sxhkdrc",
      "toml",
      "typescript",
      "vala",
      "vim",
      "yaml",
      "zig"
   },
   auto_install = true,
   highlight = {
      enable = true,
      additional_vim_regex_highlighting=false,
   },
   ident = { enable = true }, 
   rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = nil,
   }
}

-- LSP Diagnostics Options Setup 
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = ''})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = ''})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])
