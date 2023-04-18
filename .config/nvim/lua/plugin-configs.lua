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
