return {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    init = function()
        -- VimTeX configuration goes here, e.g.
        vim.g.vimtex_view_method = "zathura"
        -- Force VimTeX to use the Global Leader (Space)
        -- VimTeX uses <leader>l for all commands, so make sure no other plugin uses this command
        -- If there are conflicts -> bind only specifc commands to global leader
        vim.g.vimtex_mappings_prefix = "<leader>l"
    end,
}
