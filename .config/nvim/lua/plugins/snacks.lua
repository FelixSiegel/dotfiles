return {
    "folke/snacks.nvim",
    -- Only use it for images in makrdown/typst, so lazy load it for this files
    -- priority = 1000,
    -- lazy = false,
    ft = { "markdown", "typst" },
    opts = {
        image = {
            enabled = true,
            doc = {
                enabled = true, -- Enables inline image rendering for documents
                inline = true, -- Renders the image inline in the buffer
                float = true, -- Renders the image in a floating window (fallback/hover)
                max_width = 80,
            },
        },
    },
}
