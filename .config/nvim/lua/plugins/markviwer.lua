return {
    "OXY2DEV/markview.nvim",
    -- Only load at markdown and typst files
    ft = { "markdown", "typst", "markdown.mdx" },

    -- Completion for `blink.cmp`
    dependencies = { "saghen/blink.cmp" },
};
