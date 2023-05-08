-- Bubbly config for lualine
-- Author: awheeler294
-- Based on: 
-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

vim.opt.showmode = false

local colors = {
   color2   = '#242b38',
   color3   = '#d4bfff',
   color4   = '#d9d7ce',
   color5   = '#272d38',
   color13  = '#bbe67e',
   color10  = '#59c2ff',
   color8   = '#f07178',
   color9   = '#323A4C',
}

local ayu_bubbles_theme =  {
   visual = {
      a = { fg = colors.color2, bg = colors.color3, gui = 'bold' },
      b = { fg = colors.color4, bg = colors.color9 },
   },
   replace = {
      a = { fg = colors.color2, bg = colors.color8, gui = 'bold' },
      b = { fg = colors.color4, bg = colors.color9 },
   },
   inactive = {
      a = { fg = colors.color2, bg = colors.color9, gui = 'bold' },
      b = { fg = colors.color2, bg = colors.color9 },
      c = { fg = colors.color2, bg = colors.color2 },
   },
   normal = {
      a = { fg = colors.color2, bg = colors.color10, gui = 'bold' },
      b = { fg = colors.color4, bg = colors.color9 },
      c = { fg = colors.color9, bg = colors.color2 },
   },
   insert = {
      a = { fg = colors.color2, bg = colors.color13, gui = 'bold' },
      b = { fg = colors.color4, bg = colors.color9 },
   },
}

require('lualine').setup {
   options = {
      theme = ayu_bubbles_theme,
      component_separators = '|',
      section_separators = { left = '', right = '' },
      always_divide_middle = true,
   },
   sections = {
      lualine_a = {
         { 'mode', separator = { left = '' }, right_padding = 2 },
      },
      lualine_b = { 'filename' },
      lualine_c = {},
      lualine_x = {},
      lualine_y = { 'branch', 'filetype', 'fileformat', 'progress' },
      lualine_z = {
         { 'location', separator = {right = '' }, left_padding = 2 },
      },
   },
   inactive_sections = {
      lualine_a = {
         { 'mode', separator = { left = '' }, right_padding = 2 },
      },
      lualine_b = { 'filename' },
      lualine_c = {},
      lualine_x = {},
      lualine_y = { 'branch', 'filetype', 'fileformat', 'progress' },
      lualine_z = {
         { 'location', separator = {right = '' }, left_padding = 2 },
      },
   },
   tabline = {},
   extensions = {'toggleterm', 'nvim-tree'},
}
