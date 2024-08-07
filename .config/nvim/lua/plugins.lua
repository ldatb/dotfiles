local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- My plugins here
    -- treesitter
    use {
      'nvim-treesitter/nvim-treesitter',
      config = function()
        require'nvim-treesitter.configs'.setup {
          ensure_installed = { 'bash', 'c', 'cpp', 'go', 'python', 'json', 'yaml', 'markdown', 'markdown_inline', 'regex' },
          sync_install = true,
          auto_install = false,
          highlight = {
            enable = true,
          },
          indent = {
            enable = true,
          },
      }
    end
  }

    -- telescope
    use 'nvim-lua/plenary.nvim'
    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.7',
      requires = { {'nvim-lua/plenary.nvim'} },
      config = function()
        require("telescope").setup {
          extensions = {
            file_browser = {
              --theme = "ivy",
              hijack_netrw = true,
            },
          },
        }
        require("telescope").load_extension "file_browser"
      end
    }

    -- telescope file browser
    use {
      "nvim-telescope/telescope-file-browser.nvim",
      requires = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim"
      }
    }

    -- noice
    use 'MunifTanjim/nui.nvim'
    use {
      'folke/noice.nvim',
      requires = {
        'MunifTanjim/nui.nvim',
      },
      config = function()
        require('noice').setup({
          lsp = {
            override = {
              ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
              ['vim.lsp.util.stylize_markdown'] = true,
              ['cmp.entry.get_documentation'] = true,
            },
          },
          presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
          },
        })
      end
    }

    -- auto-close
    use {
      'm4xshen/autoclose.nvim',
      config = function()
        require("autoclose").setup()
      end
    }

    -- indent-blankline
    use 'lukas-reineke/indent-blankline.nvim'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'saadparwaiz1/cmp_luasnip'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'L3MON4D3/LuaSnip'
    use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v1.x',
      requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {
        'williamboman/mason.nvim',
        run = function() pcall(vim.cmd, 'MasonUpdate') end
      },
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
    },
    config = function()
      local lsp = require('lsp-zero').preset({
        name = 'minimal',
        set_lsp_keymaps = true,
        manage_nvim_cmp = true,
        suggest_lsp_servers = false,
      })
      lsp.setup()
    end
  }

  -- git signs
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        signs = {
          add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
          change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
          delete       = {hl = 'GitSignsDelete', text = '│', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
          topdelete    = {hl = 'GitSignsDelete', text = '│', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
          changedelete = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        },
        signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          interval = 1000,
          follow_files = true
        },
        attach_to_untracked = true,
        current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000,
        preview_config = {
          -- Options passed to nvim_open_win
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
        yadm = {
          enable = false
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          -- Actions
          map({'n', 'v'}, '<leader>ss', ':Gitsigns stage_hunk<CR>')
          map({'n', 'v'}, '<leader>uu', ':Gitsigns reset_hunk<CR>')
          map('n', '<leader>SS', gs.stage_buffer)
          map('n', '<leader>us', gs.undo_stage_hunk)
          map('n', '<leader>UU', gs.reset_buffer)
          -- map('n', '<leader>hp', gs.preview_hunk)
          -- map('n', '<leader>hb', function() gs.blame_line{full=true} end)
          -- map('n', '<leader>tb', gs.toggle_current_line_blame)
          map('n', 'gs', gs.diffthis)
          -- map('n', '<leader>hD', function() gs.diffthis('~') end)
          -- map('n', '<leader>td', gs.toggle_deleted)

          -- Text object
          map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      }
    end
  }

  -- multiple cursors
  use 'mg979/vim-visual-multi'

  -- barbar
  use 'nvim-tree/nvim-web-devicons'
  use {
    'romgrk/barbar.nvim',
    config = function()
      require("barbar").setup {
        animation = true,
        auto_hide = false,
        tabpages = false,
        clickable = true,
        insert_at_end = true,
        icons = {
          buffer_index = true,
          buffer_number = false,
          button = '',

          gitsigns = {
            added = {enabled = true, icon = '+'},
            changed = {enabled = true, icon = '~'},
            deleted = {enabled = true, icon = '-'},
          },

          filetype = {
            -- Sets the icon's highlight group.
            -- If false, will use nvim-web-devicons colors
            custom_colors = false,

            -- Requires `nvim-web-devicons` if `true`
            enabled = true,
          },

          separator = {left = '▎', right = ''},

          -- If true, add an additional separator at the end of the buffer list
          separator_at_end = true,

          -- Configure the icons on the bufferline when modified or pinned.
          -- Supports all the base icon options.
          modified = {button = '●'},
          pinned = {button = '', filename = true},

          -- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
          preset = 'default',

          -- Configure the icons on the bufferline based on the visibility of a buffer.
          -- Supports all the base icon options, plus `modified` and `pinned`.
          alternate = {filetype = {enabled = false}},
          current = {buffer_index = true},
          inactive = {button = '×'},
          visible = {modified = {buffer_number = false}},
        },
      }
    end
  }

  -- tokyo night theme
  use 'folke/tokyonight.nvim'

  -- catppuccin theme
  use { 'catppuccin/nvim', as = 'catppuccin' }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
