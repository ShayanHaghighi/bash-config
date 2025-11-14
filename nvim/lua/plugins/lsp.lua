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
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "onsails/lspkind.nvim",
      "ray-x/lsp_signature.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        completion = { autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged } },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
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

          -- Enter also confirms
          ["<CR>"] = cmp.mapping.confirm({ select = true }),

          -- Navigation with arrow keys
          ["<Up>"] = cmp.mapping.select_prev_item(),
          ["<Down>"] = cmp.mapping.select_next_item(),

          -- Optional: C-p / C-n as alternative navigation
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),

          -- Manual completion trigger
          ["<C-Space>"] = cmp.mapping.complete(),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
        sorting = {
          priority_weight = 2,
          comparators = {
            cmp.config.compare.locality,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
      })

      -- ===== LSP setup =====
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

      -- Use basedpyright for smarter Python completion
      vim.lsp.config.basedpyright = {
        cmd = { "basedpyright-langserver", "--stdio" },
        capabilities = capabilities,
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "lua", "javascript", "typescript", "python" },
        callback = function()
          local cfg = vim.lsp.config[vim.bo.filetype .. "_ls"]
            or (vim.bo.filetype == "python" and vim.lsp.config.basedpyright)
          if cfg then
            vim.lsp.start(cfg)
          end
        end,
      })

      -- ===== Signature hints =====
      require("lsp_signature").setup({
        bind = true,
        hint_enable = true,
        hint_prefix = " ",
        handler_opts = { border = "rounded" },
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
        python = { "black" },
        bash = { "beautysh" },
        shell = { "beautysh" },
        -- Conform will run multiple formatters sequentially
        --python = { "isort", "black" },
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
