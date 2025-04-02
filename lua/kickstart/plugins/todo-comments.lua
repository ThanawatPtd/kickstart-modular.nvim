-- Highlight todo, notes, etc in comments
return {
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = true,
      keywords = {
        FIX = {
          icon = '? ', -- icon used for the sign, and in search results
          color = 'error', -- can be a hex color, or a named color (see below)
          alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' }, -- removed SAFETY from here
        },
        SAFETY = {
          icon = '? ',
          color = 'error',
        },
      },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
