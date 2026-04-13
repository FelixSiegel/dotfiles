return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    dependencies = { "echasnovski/mini.icons" },
    opts = {},
    keys = {
        {
            "<c-p>",
            function() require('fzf-lua').files() end,
            desc = "Find files in project directory"
        },
        {
            "<c-g>",
            function() require('fzf-lua').live_grep() end,
            desc = "Live [G]rep current project"
        },
        {
            "<leader>bb",
            function() require('fzf-lua').buffers() end,
            desc = "Switch [B]uffers"
        },
        {
            "<leader>cs",
            function() require('fzf-lua').colorschemes() end,
            desc = "Select [C]olor[S]cheme"
        },
        {
            "<leader>fb",
            function() require('fzf-lua').builtin() end,
            desc = "Fuzzy search [F]zfLua [B]uiltins"
        },
        {
            "<leader>fh",
            function() require('fzf-lua').helptags() end,
            desc = "[F]ind [H]elp"
        },
        {
            "<leader>fk",
            function() require('fzf-lua').keymaps() end,
            desc = "[F]ind [K]eymap"
        },
        {
            "<leader>gf",
            function() require('fzf-lua').git_files() end,
            desc = "[G]it [F]iles"
        },
        {
            "<leader>gs",
            function() require('fzf-lua').git_status() end,
            desc = "[G]it [S]tatus"
        },
        {
            "<leader>gc",
            function() require('fzf-lua').git_commits() end,
            desc = "[G]it [C]ommits"
        },
        {
            "<leader>gC",
            function() require('fzf-lua').git_bcommits() end,
            desc = "[G]it Buffer [C]ommits"
        },
        {
            "<leader>gb",
            function() require('fzf-lua').git_branches() end,
            desc = "[G]it [B]ranches"
        },
        {
            "<leader>gS",
            function() require('fzf-lua').git_stash() end,
            desc = "[G]it [S]tash"
        }

    }
}
