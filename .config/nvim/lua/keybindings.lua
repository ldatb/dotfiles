-- telescope
vim.api.nvim_set_keymap(
  "n",
  "t",
  ":Telescope",
  { noremap = true }
)

-- telescope file browser
vim.api.nvim_set_keymap(
  "n",
  "fb",
  ":Telescope file_browser path=%:p:h select_buffer=true respect_gitignore=false hidden=true grouped=true previewer=false initial_mode=normal",
  { noremap = true }
)
