vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

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
      'nvim-telescope/telescope.nvim', tag = '0.1.1',
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
    }
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

    -- tokyo night theme
    use 'folke/tokyonight.nvim'
end)
