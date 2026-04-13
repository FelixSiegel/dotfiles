return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },
    config = function()
        local theme = require("lualine.themes.catppuccin-nvim")

        -- Override normal mode to use mauve instead of blue
        theme.normal.a.bg = "#c6a0f6"
        theme.normal.b.fg = "#c6a0f6"

        require("lualine").setup({
            options = {
                theme = theme,
            },
        })
    end,
}
