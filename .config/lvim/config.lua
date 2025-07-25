-- plugins
lvim.plugins = {
  { "lunarvim/colorschemes" },
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    config = function()
      require('github-theme').setup({
        options = {
          transparent = true,
        }
      })

      vim.cmd('colorscheme github_dark')
    end,
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
      if bg then
        bg = string.format("#%06x", bg)
      else
        bg = "#000000"
      end
      require("notify").setup({
        background_colour = bg,
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },
}

-- noice
require("noice").setup({
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = false,
  },
})

-- appearance
lvim.colorscheme = "github_dark_high_contrast"

-- vim.lsp.util.make_position_params
local orig_make_position_params = vim.lsp.util.make_position_params

vim.lsp.util.make_position_params = function(bufnr, encoding)
  local clients = vim.lsp.get_active_clients({ bufnr = bufnr or 0 })
  local enc = encoding or (clients[1] and clients[1].offset_encoding) or "utf-16"
  return orig_make_position_params(bufnr or 0, enc)
end
