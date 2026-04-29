local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node

local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt
local line_begin = require("luasnip.extras.conditions.expand").line_begin

local function in_mathzone()
    if vim.fn.exists("*vimtex#syntax#in_mathzone") == 0 then
        return false
    end
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

-- list of math keywords for autocompletion without leading backslash
local math_symbols = {
    "alpha",
    "beta",
    "gamma",
    "delta",
    "epsilon",
    "varepsilon",
    "zeta",
    "eta",
    "theta",
    "lambda",
    "mu",
    "pi",
    "phi",
    "varphi",
    "infty",
    "approx",
    "equiv",
    "neq",
    "leq",
    "geq",
    "cdot",
    "nabla",
    "forall",
    "exists",
    "in",
    "notin",
    "subset",
    "subseteq",
    "supset",
    "supseteq",
    "setminus",
}

local regular_snippets = {}

-- Dynamically generate a snippet for each symbol
for _, sym in ipairs(math_symbols) do
    table.insert(
        regular_snippets,
        s({
            trig = sym,
            condition = in_mathzone, -- Prevents expansion if forced

            -- show_condition dictates visibility in the blink.cmp menu
            show_condition = function()
                -- Hide if not in a math environment
                if not in_mathzone() then
                    return false
                end
                return true
            end,
        }, {
            f(function()
                -- Get the cursor column position (0-indexed byte offset)
                local col = vim.api.nvim_win_get_cursor(0)[2]
                local line = vim.api.nvim_get_current_line()

                -- Get the character exactly before the cursor
                local char_before = line:sub(col, col)

                if char_before == "\\" then
                    -- If user already typed '\', just return the word
                    return sym
                else
                    -- If user just typed the word, inject the '\'
                    return "\\" .. sym
                end
            end, {}),
        })
    )
end

-- Auto-expand subscripts: a_ij -> a_{ij}
local auto_subscript = s(
    {
        trig = "([%a%)%]%}])_(%w%w+)",
        regTrig = true,
        wordTrig = false,
        condition = in_mathzone,
    },
    f(function(_, snip)
        return snip.captures[1] .. "_{" .. snip.captures[2] .. "}"
    end, {})
)

-- Auto-expand superscripts: a^ij -> a^{ij}
local auto_superscript = s(
    {
        trig = "([%a%)%]%}])%^(%w%w+)",
        regTrig = true,
        wordTrig = false,
        condition = in_mathzone,
    },
    f(function(_, snip)
        return snip.captures[1] .. "^{" .. snip.captures[2] .. "}"
    end, {})
)

-- Auto-expand negative superscripts: ^-1 -> ^{-1}
local auto_negative_superscript = s(
    {
        trig = "([%a%)%]%}])%^%-(%w+)",
        regTrig = true,
        wordTrig = false,
        condition = in_mathzone,
    },
    f(function(_, snip)
        return snip.captures[1] .. "^{-" .. snip.captures[2] .. "}"
    end, {})
)

-- Auto-expand negative subscripts: _-1 -> _{-1}
local auto_negative_subscript = s(
    {
        trig = "([%a%)%]%}])_%-(%w+)",
        regTrig = true,
        wordTrig = false,
        condition = in_mathzone,
    },
    f(function(_, snip)
        return snip.captures[1] .. "_{-" .. snip.captures[2] .. "}"
    end, {})
)

-- Auto-expand fractions: a/b -> \frac{a}{b}, (abc)/(xy) -> \frac{abc}{xy}
local auto_frac = s(
    {
        trig = "([%a%)%]%}%(][%a%)%]%}%(]*)/([%a%)%]%}%(][%a%)%]%}%(]*)",
        regTrig = true,
        wordTrig = false,
        condition = in_mathzone,
    },
    f(function(_, snip)
        local numerator = snip.captures[1]
        local denominator = snip.captures[2]

        -- Don't expand if denominator starts with ( but doesn't end with )
        if denominator:sub(1, 1) == "(" and denominator:sub(-1) ~= ")" then
            return numerator .. "/" .. denominator
        end

        -- Similarly for numerator
        if numerator:sub(1, 1) == "(" and numerator:sub(-1) ~= ")" then
            return numerator .. "/" .. denominator
        end

        -- Remove outer parentheses if present
        if numerator:match("^%(.*%)$") then
            numerator = numerator:sub(2, -2)
        end
        if denominator:match("^%(.*%)$") then
            denominator = denominator:sub(2, -2)
        end

        return "\\frac{" .. numerator .. "}{" .. denominator .. "}"
    end, {})
)

local function generate_matrix(_, snip)
    local rows = tonumber(snip.captures[1])
    local cols = tonumber(snip.captures[2])
    local nodes = {}
    local ins_indx = 1
    for r = 1, rows do
        for c = 1, cols do
            table.insert(nodes, i(ins_indx))
            ins_indx = ins_indx + 1
            if c < cols then
                table.insert(nodes, t(" & "))
            end
        end
        if r < rows then
            table.insert(nodes, t({ " \\\\ ", "\t" }))
        end
    end
    return sn(nil, nodes)
end

-- Return: first table is regular snippets, second is autosnippets
return regular_snippets,
    {
        auto_subscript,
        auto_superscript,
        auto_negative_superscript,
        auto_negative_subscript,
        auto_frac,
        -- Inline Math
        s({ trig = "mm", snippetType = "autosnippet" }, {
            t("\\( "),
            i(1),
            t(" \\)"),
            i(0),
        }),

        -- Display Math
        s(
            { trig = "md", snippetType = "autosnippet" },
            fmt(
                [[
\[
    <>
\]
<>
    ]],
                { i(1), i(0) },
                { delimiters = "<>" }
            )
        ),
        s({ trig = "(%d)(%d)mat", regTrig = true, snippetType = "autosnippet", condition = in_mathzone }, {
            t("\\begin{pmatrix}"),
            t({ "", "\t" }),
            d(1, generate_matrix),
            t({ "", "\\end{pmatrix}" }),
            i(0),
        }),
        s({ trig = "scal", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, {
            t("\\langle "),
            i(1),
            t(", "),
            i(2),
            t(" \\rangle"),
        }),
        s(
            { trig = "def", snippetType = "autosnippet", condition = line_begin },
            fmt(
                [[
\begin{definition}{<>}{<>}
    <>
\end{definition}
        ]],
                { i(1, "Titel"), i(2, "label"), i(0) },
                { delimiters = "<>" }
            )
        ),
        s(
            { trig = "satz", snippetType = "autosnippet", condition = line_begin },
            fmt(
                [[
\begin{satz}{<>}{<>}
    <>
\end{satz}
        ]],
                { i(1, "Titel"), i(2, "label"), i(0) },
                { delimiters = "<>" }
            )
        ),
        s(
            { trig = "prop", snippetType = "autosnippet", condition = line_begin },
            fmt(
                [[
\begin{proposition}{<>}{<>}
    <>
\end{proposition}
        ]],
                { i(1, "Titel"), i(2, "label"), i(0) },
                { delimiters = "<>" }
            )
        ),
        s(
            { trig = "folg", snippetType = "autosnippet", condition = line_begin },
            fmt(
                [[
\begin{fol}{<>}{<>}
    <>
\end{folgerung}
        ]],
                { i(1, "Titel"), i(2, "label"), i(0) },
                { delimiters = "<>" }
            )
        ),
        s(
            { trig = "bsp", snippetType = "autosnippet", condition = line_begin },
            fmt(
                [[
\begin{beispiel}{<>}{}
    <>
\end{beispiel}
        ]],
                { i(1, ""), i(0) },
                { delimiters = "<>" }
            )
        ),
        s(
            { trig = "bem", snippetType = "autosnippet", condition = line_begin },
            fmt(
                [[
\begin{bemerkung}{<>}{}
    <>
\end{bemerkung}
        ]],
                { i(1, ""), i(0) },
                { delimiters = "<>" }
            )
        ),
    }
