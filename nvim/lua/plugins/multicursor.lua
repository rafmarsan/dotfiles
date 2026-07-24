return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",

  config = function()
    local mc = require("multicursor-nvim")

    mc.setup()

    vim.keymap.set({ "n", "x" }, "<C-d>", function()
      mc.matchAddCursor(1)
    end, { desc = "Next match" })

    mc.addKeymapLayer(function(layer)
      layer({ "n", "x" }, "<Esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end)
    end)
  end,
}
