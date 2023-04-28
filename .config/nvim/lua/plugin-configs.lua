-- nvim-treesitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "bash", "c", "cpp", "go", "python", "json", "yaml", "markdown", "markdown_inline", "regex" },
    sync_install = true,
    auto_install = false,
    highlight = {
      enable = true,
    },
}

-- indent-blankline
require("indent_blankline").setup {
  show_current_context = true,
  show_current_context_start = true,
}

-- telescope
require("telescope").setup {
  extensions = {
    file_browser = {
      theme = "ivy",
      hijack_netrw = true,
    },
  },
}
require("telescope").load_extension "file_browser"
vim.api.nvim_set_keymap(
  "n",
  "fb",
  ":Telescope file_browser path=%:p:h select_buffer=true respect_gitignore=false hidden=true grouped=true previewer=false initial_mode=normal",
  { noremap = true }
)
