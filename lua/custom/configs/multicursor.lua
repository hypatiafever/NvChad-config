local mc = require("multicursor-nvim")

local set = vim.keymap.set

-- Add or skip cursor above/below the main cursor.
set({"n", "x"}, "<M-k>", function() mc.lineAddCursor(-1) end, {desc = "Add cursor above"})
set({"n", "x"}, "<M-j>", function() mc.lineAddCursor(1) end, {desc = "Add cursor below"})
set({"n", "x"}, "<leader><M-k>", function() mc.lineSkipCursor(-1) end, {desc = "Skip line, cursor above"})
set({"n", "x"}, "<leader><M-j>", function() mc.lineSkipCursor(1) end, {desc = "Skip line, cursor below"})

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
    layerSet({"n", "x"}, "<C-x>", mc.deleteCursor, {desc = "Delete main cursor"})

    -- Enable and clear cursors using escape.
    layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then
            mc.enableCursors()
        else
            mc.clearCursors()
        end
    end)
end)
