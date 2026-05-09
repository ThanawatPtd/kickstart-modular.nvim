return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
      -- Install parsers on startup
      require('nvim-treesitter').install {
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

      -- Highlighting and indent are enabled by default via Neovim's built-in treesitter.
      -- Enable treesitter-based folding (optional)
      vim.o.foldmethod = 'expr'
      vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.o.foldlevel = 99
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
