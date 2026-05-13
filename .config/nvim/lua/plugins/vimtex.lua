return {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    init = function()
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_compiler_method = "latexmk" -- or tectonic
        vim.g.vimtex_compiler_latexmk = {
            continuous = 0, -- disable compile on save
            out_dir = "build", -- Keeps your folder clean!
            options = {
                "-lualatex",
                "-shell-escape",
                "-verbose",
                "-file-line-error",
                "-synctex=1",
                "-interaction=nonstopmode",
            },
        }

        -- Force VimTeX to use the Global Leader (Space)
        vim.g.vimtex_mappings_prefix = "<leader>l"

        -- Set conceallevel (2 = conceal text unless it's on the current line)
        vim.opt.conceallevel = 0
        vim.opt.concealcursor = "" -- Show conceal on cursor line in all modes
    end,
}
