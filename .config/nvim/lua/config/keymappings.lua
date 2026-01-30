vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Open parent directory using Oil" })
vim.keymap.set("n", "gl", function()
    vim.diagnostic.open_float()
end, { desc = "Open diagnostics" })
vim.keymap.set("n", "ff", function()
    require("conform").format({ async = true })
end, { desc = "[F]ormat [F]ile" })

-- Open a terminal in a horizontal split
vim.keymap.set("n", "<leader>tt", "<cmd>split | terminal<CR>", { desc = "Open terminal (split)" })

