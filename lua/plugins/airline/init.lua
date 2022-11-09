local g = vim.g

g.airline_theme='owo'



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

vim.cmd([[
  function! LspStatus() abort
    if luaeval('#vim.lsp.buf_get_clients() > 0')
      return luaeval("require('lsp-status').status()")
    endif
  
    return ''
  endfunction
  let g:lsp_wait_added = 0
  let g:lsp_wait_done = 0
  function! LspWait(...)
      let builder = a:1
      let context = a:2
      call builder.add_section('airline_b', '...')
      return 0
  endfunction
]])

vim.cmd([[
  function! LspStatus() abort
    let status = luaeval('require("lsp-status").status()')
    return trim(status)
  endfunction
  call airline#parts#define_function('lsp_status', 'LspStatus')
  call airline#parts#define_condition('lsp_status', 'luaeval("#vim.lsp.buf_get_clients() > 0")')
]])

vim.cmd([[
  let g:airline#extensions#nvimlsp#enabled = 0
  let g:airline_section_x = airline#section#create_left(['lsp_status'])
]])

