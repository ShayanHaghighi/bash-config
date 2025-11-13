return {
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      local nvim_tree = require("nvim-tree")

      local function on_attach(bufnr)
        local api = require("nvim-tree.api")

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- TODO: fix
        vim.keymap.set("n", "<leader>t", api.tree.focus, { buffer = bufnr, desc = "Focus NvimTree" })
      end

      nvim_tree.setup({
        on_attach = on_attach,
        update_cwd = true,
        update_focused_file = {
          enable = true,
          update_cwd = true,
        },
        hijack_cursor = true,
        view = {
          side = "left",
          width = 35,
        },
        renderer = {
          highlight_git = true, -- color git status
          highlight_opened_files = "all",
          highlight_modified = "icon",
          root_folder_label = ":t", -- shorten root folder name
          full_name = false,
          indent_markers = { enable = true },
          add_trailing = false,
          icons = {
            webdev_colors = true,
            git_placement = "after",
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
            glyphs = {
              default = "󰈙",
              symlink = "",
              folder = {
                arrow_closed = "",
                arrow_open = "",
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "",
              },
              git = {
                unstaged = "M",
                staged = "S",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
          },
        },
      })

      vim.cmd([[
  hi NvimTreeGitNewIcon guifg=#ff4444 gui=bold

  hi NvimTreeGitStagedIcon guifg=#00ff7f gui=bold

  hi NvimTreeGitDirtyIcon guifg=#ffb347 gui=bold
    ]])
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = false, -- load immediately so icons are available everywhere
    priority = 1000,
    config = function()
      require("nvim-web-devicons").setup({
        override = {},
        color_icons = true,
        default = true, -- show default icons for files with no specific icon
        strict = true, -- match exact file extensions
      })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({ options = { theme = "auto" } })
    end,
  }, -- nvim status line
  { -- theme
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  { -- bufferlines (tabs)
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          diagnostics = "nvim_lsp",
          separator_style = "slant", -- "thin", "slant", or "padded_slant"
          show_buffer_close_icons = false,
          show_close_icon = false,
          always_show_bufferline = true,
        },
      })

      -- Optional keymaps for tab switching
      vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next tab" })
      vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Prev tab" })
    end,
  },
  { -- smart window tiling
    "mrjones2014/smart-splits.nvim",
    config = function()
      local splits = require("smart-splits")

      -- Movement between splits
      vim.keymap.set("n", "<C-h>", splits.move_cursor_left)
      vim.keymap.set("n", "<C-j>", splits.move_cursor_down)
      vim.keymap.set("n", "<C-k>", splits.move_cursor_up)
      vim.keymap.set("n", "<C-l>", splits.move_cursor_right)

      -- Resizing splits
      vim.keymap.set("n", "<A-h>", splits.resize_left)
      vim.keymap.set("n", "<A-j>", splits.resize_down)
      vim.keymap.set("n", "<A-k>", splits.resize_up)
      vim.keymap.set("n", "<A-l>", splits.resize_right)

      vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
      vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
      vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
      vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
    end,
  },
}
