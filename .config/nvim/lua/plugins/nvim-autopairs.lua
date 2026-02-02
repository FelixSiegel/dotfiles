return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        local autopairs = require("nvim-autopairs")

        autopairs.setup({
            check_ts = true, -- Enable treesitter integration for context-aware pairing
        })
    end,
}
