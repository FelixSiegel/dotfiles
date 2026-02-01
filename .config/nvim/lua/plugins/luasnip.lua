return {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*",
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    config = function()
        local ls = require("luasnip")

        -- Load VSCode-style snippets from JSON
        require("luasnip.loaders.from_vscode").lazy_load({
            paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
        })

        -- Load Lua snippets (for auto-snippets)
        require("luasnip.loaders.from_lua").lazy_load({
            paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
        })

        -- Enable autotrigger for snippets
        ls.config.set_config({
            enable_autosnippets = true,
            -- Update more often for smoother experience
            update_events = "TextChanged,TextChangedI",
            -- Check for autosnippets after every character
            region_check_events = "InsertEnter,CursorMoved,CursorMovedI",
        })
    end,
}
