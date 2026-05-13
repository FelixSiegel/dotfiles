return {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
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

            -- Important: do not keep old snippet jump history
            history = false,

            -- Update more often for smoother experience
            update_events = "TextChanged,TextChangedI",

            -- Remove snippets whose region was deleted/left
            delete_check_events = "TextChanged,TextChangedI,InsertLeave",

            -- Check for autosnippets after every character
            region_check_events = "InsertEnter,CursorMoved,CursorMovedI",
        })

        -- Hard reset snippet state when leaving insert mode.
        -- This prevents Tab from jumping to old snippet nodes later.
        -- vim.api.nvim_create_autocmd("InsertLeave", {
        --     group = vim.api.nvim_create_augroup("luasnip_cleanup", { clear = true }),
        --     callback = function()
        --         if ls.session.current_nodes[vim.api.nvim_get_current_buf()] then
        --             ls.unlink_current()
        --         end
        --     end,
        -- })
    end,
}
