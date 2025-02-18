-- return {}
return {
  'rebelot/kanagawa.nvim',
  priority = 1000,
  config = function()
    vim.cmd 'colorscheme kanagawa-wave'
  end,
}

-- vim.cmd("colorscheme kanagawa-wave") wave theme
-- vim.cmd("colorscheme kanagawa-dragon")dragon theme
-- vim.cmd("colorscheme kanagawa-lotus")lotus theme
