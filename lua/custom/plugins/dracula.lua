return {
  {
    'Mofiqul/dracula.nvim',
    lazy = false, -- load the theme on startup
    priority = 1001, -- load before other plugins
    config = function()
      vim.cmd.colorscheme 'dracula'
    end,
  },
}
