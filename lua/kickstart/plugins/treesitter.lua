return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
      -- Install missing parsers on startup (skips already-installed ones)
      local parsers = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'rust',
        'typescript',
        'javascript',
        'go',
        'java',
        'c_sharp',
      }
      local ts = require 'nvim-treesitter'
      local missing = vim.tbl_filter(function(lang)
        return not pcall(vim.treesitter.language.inspect, lang)
      end, parsers)
      if #missing > 0 then
        ts.install(missing)
      end

      -- Highlighting and indent are enabled by default via Neovim's built-in treesitter.
      -- Enable treesitter-based folding (optional)
      vim.o.foldmethod = 'expr'
      vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.o.foldlevel = 99
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
