local g = vim.g


local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

local colors = {
  yellow = '#ECBE7B',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#98be65',
  orange = '#FF8800',
  violet = '#a9a1e1',
  magenta = '#c678dd',
  blue = '#51afef',
  red = '#ec5f67'
}

local config = {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = vim.go.laststatus == 3,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', {'diagnostics', symbols = {
      error = '✖',
      warn = '',
      info = '',
      hint = '⚡'
    } }},
    lualine_c = { 'filename' },
    lualine_x = {  },
    lualine_y = { 'encoding', 'fileformat', 'filetype', 'progress' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_right {
  'lsp_progress',
	colors = {
    percentage  = colors.cyan,
	  title  = colors.cyan,
	  message  = colors.cyan,
	  spinner = colors.cyan,
	  lsp_client_name = colors.magenta,
	  use = true,
	},
	separators = {
    component = ' ',
		progress = '',
		message = { pre = '(', post = ')'},
		percentage = { pre = '[', post = '%%]' },
		title = { pre = '', post = ': ' },
		lsp_client_name = { pre = '[', post = ']' },
		spinner = { pre = '', post = '' },
	},
	display_components = { { 'title', 'message', 'percentage' }, 'spinner', 'lsp_client_name'  },
	timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = -1 },
	spinner_symbols = { '', '', '', '', '','', '', '' },
  message = { commenced = 'In Progress', completed = 'Completed' },
}
--g.airline_theme='deus'

require('lualine').setup(config)


g.airline_left_sep = ''
g.airline_left_alt_sep = ''
g.airline_right_sep = ''
g.airline_right_alt_sep = ''
local function n()
  local diagnostics = vim.lsp.diagnostic.get_line_diagnostics()
  if not next(diagnostics) then return end
  return diagnostics[1].message
end

--g.airline_symbols.branch = ''
--g.airline_symbols.readonly = ''
--g.airline_symbols.linenr = '☰'
--g.airline_symbols.maxlinenr = ''
--g.airline_symbols.dirty='⚡'
-- 
--vim.cmd([[
--  function! LspStatus() abort
--    if luaeval('#vim.lsp.buf_get_clients() > 1')
--      return luaeval("require('lsp-status').status()")
--    endif
--  
--    return ''
--  endfunction
--  let g:lsp_wait_added = 1
--  let g:lsp_wait_done = 1
--  function! LspWait(...)
--      let builder = a:2
--      let context = a:3
--      call builder.add_section('airline_b', '...')
--      return 1
--  endfunction
--]])
-- 
--vim.cmd([[
--  function! LspStatus() abort
--    let status = luaeval('require("lsp-status").status()')
--    return trim(status)
--  endfunction
--  call airline#parts#define_function('lsp_status', 'LspStatus')
--  call airline#parts#define_condition('lsp_status', 'luaeval("#vim.lsp.buf_get_clients() > 1")')
--]])
-- 
--vim.cmd([[
--  let g:airline#extensions#nvimlsp#enabled = 1
--  let g:airline_section_x = airline#section#create_left(['lsp_status'])
--]])

