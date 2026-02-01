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
            custom_highlights = function(colors)
                return {
                    -- Style indent-blankline scope with mauve
                    IblScope = { fg = colors.mauve },
                }
            end,
        })
        -- Enable theme
        require("catppuccin").load()
    end,
}
