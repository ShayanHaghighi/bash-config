return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "python", "javascript", "typescript", "html", "css" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  { "neovim/nvim-lspconfig" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      -- ===== Autocompletion (cmp) =====
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true })
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
      })

      -- ===== LSP Setup (new API) =====
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config.lua_ls = {
        cmd = { "lua-language-server" },
        capabilities = capabilities,
        settings = {
          Lua = { diagnostics = { globals = { "vim" } } },
        },
      }

      vim.lsp.config.ts_ls = {
        cmd = { "typescript-language-server", "--stdio" },
        capabilities = capabilities,
      }

      vim.lsp.config.pyright = {
        cmd = { "pyright-langserver", "--stdio" },
        capabilities = capabilities,
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "lua", "javascript", "typescript", "python" },
        callback = function()
          local cfg = vim.lsp.config[vim.bo.filetype .. "_ls"]
          if cfg then
            vim.lsp.start(cfg)
          end
        end,
      })
    end,
  },
  { "williamboman/mason.nvim", config = true },

  {
    "HiPhish/nvim-ts-rainbow2",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        rainbow = {
          enable = true,
          strategy = require("ts-rainbow.strategy.global"),
          query = { "rainbow-parens", html = "rainbow-tags" },
        },
      })
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = { char = "│" },
      scope = { enabled = true },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        stylua = { prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" } },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        json = { "fixjson" },
        -- Conform will run multiple formatters sequentially
        --python = { "isort", "black" },
        -- You can customize some of the format options for the filetype (:help conform.format)
        --rust = { "rustfmt", lsp_format = "fallback" },
        -- Conform will run the first available formatter
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
      format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true,
      },
    },
  },
}
