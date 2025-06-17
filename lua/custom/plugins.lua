local plugins = {
  -- utilities
  {

    "L3MON4D3/LuaSnip",
    event = "VeryLazy",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",

    require("luasnip.loaders.from_vscode").load_standalone({path="./configs/snippets/cpp.code-snippets"})
  },
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    event = "VeryLazy",
    config = function()
        local mc = require("multicursor-nvim")
        mc.setup()
        require "custom.configs.multicursor"
        -- Customize how cursors look.
        local hl = vim.api.nvim_set_hl
        hl(0, "MultiCursorCursor", { reverse = true })
        hl(0, "MultiCursorVisual", { link = "Visual" })
        hl(0, "MultiCursorSign", { link = "SignColumn"})
        hl(0, "MultiCursorMatchPreview", { link = "Search" })
        hl(0, "MultiCursorDisabledCursor", { reverse = true })
        hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
    end
  },
  -- -------------------
  -- DEBUGGING SECTION
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      require("dapui").setup()
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      require("core.utils").load_mappings("dapui")
    end
  },  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
      ensure_installed = {
        "codelldb",
      }
    },
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("core.utils").load_mappings("dap")
      require "custom.configs.dap"
    end
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      require("core.utils").load_mappings("dap_python")
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    opts = function()
     return require "custom.configs.null-ls"
    end,
  },
  -- -----------------------------
  -- custom lsp stuff
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  -- ------------------------------
  -- shitty fun little stuff
  {
    'tamton-aquib/duck.nvim',
    event = "VeryLazy",
    config = function()
        vim.keymap.set('n', '<leader><leader>dd', function() require("duck").hatch() end, {desc="Hatch duck"})
        vim.keymap.set('n', '<leader><leader>dk', function() require("duck").cook() end, {desc="Cook duck"})
        vim.keymap.set('n', '<leader><leader>da', function() require("duck").cook_all() end, {desc="Cook all duck"})
    end
  },
  {
    "seandewar/killersheep.nvim",
    event="VeryLazy",
  },
  -- ----------------------
  -- mason ensures for custom plugins
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- c/c++ debugging and formatting
        "clangd",
        "clang-format",
        "codelldb",
        -- python debugging and formatting
        "black",
        "debugpy",
        "mypy",
        "ruff",
        "pyright",
      }
    }
  }
  -- -------------------------
}

return plugins
