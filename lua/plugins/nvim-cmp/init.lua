local cmp = require('cmp')
local icons = require('markus.icons')
local merge = require('util').merge
local luasnip = require('luasnip')
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local default_cmp_opts = {
  enabled = function()
    -- disable completion in comments
    local context = require('cmp.config.context')
    -- keep command mode completion enabled when cursor is in a comment
    if vim.api.nvim_get_mode().mode == 'c' then
      return true
    else
      return not context.in_treesitter_capture('comment') and not context.in_syntax_group('Comment')
    end
  end,
  snippet = {
    expand = function(args)
      -- luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- disabled for autopairs mapping
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
       elseif luasnip.expand_or_jumpable() then
         luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
  }),
  window = {
    completion = {
      
      winhighlight = 'FloatBorder:FloatBorder,Normal:Normal',
    },
    documentation = {
      
      winhighlight = 'FloatBorder:FloatBorder,Normal:Normal',
    },
  },
  experimental = {
    ghost_text = true,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'crates' }
  }),
  formatting = {
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format('%s %s', icons.kind_icons[vim_item.kind], vim_item.kind)
      vim_item.menu = ({
        nvim_lsp = '[lsp]',
        luasnip = '[snip]',
        buffer = '[buf]',
        path = '[path]',
        nvim_lua = '[nvim_api]',
      })[entry.source.name]
      return vim_item
    end,
  },
}

cmp.setup(default_cmp_opts)
local null_ls = require('null-ls')
require('crates').setup {
    null_ls = {
        enabled = true,
        name = "crates.nvim",
    },
}