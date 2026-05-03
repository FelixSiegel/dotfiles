return {
    "vyfor/cord.nvim",
    build = ":Cord update",
    event = "VeryLazy",
    opts = {
        text = {
            workspace = " ",
        },
        display = {
            theme = "catppuccin",
            flavor = "dark"
        }
    },
}
