return {
  'mbbill/undotree',
  vim.keymap.set('n', '<leader>o', vim.cmd.UndotreeToggle),
  vim.keymap.set('n', '<leader>O', vim.cmd.UndotreeFocus),
}
