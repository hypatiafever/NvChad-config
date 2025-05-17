local plugins = {
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    event = "VeryLazy",
    config = function()
        local mc = require("multicursor-nvim")
        mc.setup()

        local set = vim.keymap.set

        -- Add or skip cursor above/below the main cursor.
        set({"n", "x"}, "<leader><up>", function() mc.lineAddCursor(-1) end, {desc = "Add cursor above"})
        set({"n", "x"}, "<leader><down>", function() mc.lineAddCursor(1) end, {desc = "Add cursor below"})
        set({"n", "x"}, "<leader><leader><up>", function() mc.lineSkipCursor(-1) end, {desc = "Skip line, cursor above"})
        set({"n", "x"}, "<leader><leader><down>", function() mc.lineSkipCursor(1) end, {desc = "Skip line, cursor below"})

        -- Add or skip adding a new cursor by matching word/selection
        set({"n", "x"}, "<leader>n", function() mc.matchAddCursor(1) end, {desc = "Add cursor, match forward"})
        set({"n", "x"}, "<leader>s", function() mc.matchSkipCursor(1) end, {desc = "Add cursor, skip match forward"})
        set({"n", "x"}, "<leader>N", function() mc.matchAddCursor(-1) end, {desc = "Add cursor, match backwards"})
        set({"n", "x"}, "<leader>S", function() mc.matchSkipCursor(-1) end, {desc = "Add cursor, skip match backwards"})

        set("x", "<leader>t", function() mc.transposeCursors(1) end,{desc = "Rotate visual selection forward"})
        set("x", "<leader>T", function() mc.transposeCursors(-1) end,{desc = "Rotate visual selection backwards"})

        -- Add and remove cursors with control + left click.
        set("n", "<c-leftmouse>", mc.handleMouse)
        set("n", "<c-leftdrag>", mc.handleMouseDrag)
        set("n", "<c-leftrelease>", mc.handleMouseRelease)

        -- Disable and enable cursors.
        set({"n", "x"}, "<c-q>", mc.toggleCursor, {desc = "Disable/enable cursors"})

        -- Mappings defined in a keymap layer only apply when there are
        -- multiple cursors. This lets you have overlapping mappings.
        mc.addKeymapLayer(function(layerSet)

            -- Select a different cursor as the main one.
            layerSet({"n", "x"}, "<left>", mc.prevCursor, {desc = "Previous cursor"})
            layerSet({"n", "x"}, "<right>", mc.nextCursor, {desc = "Next cursor"})

            -- Delete the main cursor.
            layerSet({"n", "x"}, "<leader>x", mc.deleteCursor, {desc = "Delete main cursor"})

            -- Enable and clear cursors using escape.
            layerSet("n", "<esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end)
        end)

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
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function ()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
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
    end
  },
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    opts = function()
     return require "custom.configs.none-ls"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "clang-format",
        "codelldb",
      }
    }
  }
}

return plugins
