local opts = { noremap = true }

-- telescope
vim.api.nvim_set_keymap(
  "n",
  "t",
  ":Telescope<CR>",
  opts
)

-- telescope file browser
vim.api.nvim_set_keymap(
  "n",
  "fb",
  ":Telescope file_browser path=%:p:h select_buffer=true respect_gitignore=false hidden=true grouped=true previewer=false initial_mode=normal<CR>",
  opts
)

-- git signs
vim.api.nvim_set_keymap(
  "n",
  "gb",
  ":Gitsigns toggle_current_line_blame<CR>",
  opts
)

-- barbar
local barbar_map = vim.api.nvim_set_keymap
vim.api.nvim_set_keymap(
  "n",
  "bbe",
  ":BarbarEnable<CR>",
  opts
)
vim.api.nvim_set_keymap(
  "n",
  "bbd",
  ":BarbarDisable",
  opts
)
barbar_map('n', ',', '<Cmd>BufferPrevious<CR>', opts)
barbar_map('n', '.', '<Cmd>BufferNext<CR>', opts)
barbar_map('n', 'cc', '<Cmd>BufferClose<CR>', opts)
-- Goto buffer in position...
barbar_map('n', '<Space>1', '<Cmd>BufferGoto 1<CR>', opts)
barbar_map('n', '<Space>2', '<Cmd>BufferGoto 2<CR>', opts)
barbar_map('n', '<Space>3', '<Cmd>BufferGoto 3<CR>', opts)
barbar_map('n', '<Space>4', '<Cmd>BufferGoto 4<CR>', opts)
barbar_map('n', '<Space>5', '<Cmd>BufferGoto 5<CR>', opts)
barbar_map('n', '<Space>6', '<Cmd>BufferGoto 6<CR>', opts)
barbar_map('n', '<Space>7', '<Cmd>BufferGoto 7<CR>', opts)
barbar_map('n', '<Space>8', '<Cmd>BufferGoto 8<CR>', opts)
barbar_map('n', '<Space>9', '<Cmd>BufferGoto 9<CR>', opts)
barbar_map('n', '<Space>0', '<Cmd>BufferLast<CR>', opts)
-- Sort automatically by...
barbar_map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
barbar_map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
barbar_map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
barbar_map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)
