return {
    "nvim-treesitter/nvim-treesitter",
    tag = "v0.10.0",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "markdown",
                "markdown_inline",
                "elixir",
                "heex",
                "javascript",
                "html",
                "cpp",
                "python",
                "rust"
            },
            auto_install = true,
            sync_install = false,
            highlight = {
                enable = true,
                disable = { "latex" }, -- Disable tree sitter  for LaTeX as VimTeX is doing this part
            },
            indent = { enable = true },
            fold = { enable = true },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn", -- set to `false` to disable one of the mappings
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm",
                },
            },
        })
    end,
}
