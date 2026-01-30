return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- load before all the other start plugins
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",
            background = { -- :h background
                light = "latte",
                dark = "mocha",
            },
        })
        -- Enable theme
        require("catppuccin").load()
    end,
}
