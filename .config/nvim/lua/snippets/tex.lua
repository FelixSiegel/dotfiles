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
return {}, {
    auto_subscript,
    auto_superscript,
    auto_negative_superscript,
    auto_negative_subscript,
    auto_frac,
    s({ trig = "(%d)(%d)mat", regTrig = true, snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\begin{pmatrix}"),
        t({ "", "\t" }),
        d(1, generate_matrix),
        t({ "", "\\end{pmatrix}" }),
        i(0),
    }),
    s({ trig = "vabs", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\lvert "),
        i(1),
        t(" \\rvert"),
    }),
    s({ trig = "scal", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\langle "),
        i(1),
        t(", "),
        i(2),
        t(" \\rangle"),
    }),
    s({ trig = "def", snippetType = "autosnippet", condition = line_begin }, fmt(
        [[
\begin{definition}{<>}{<>}
    <>
\end{definition}
        ]],
        { i(1, "Titel"), i(2, "label"), i(0) },
        { delimiters = "<>" }
    )),
    s({ trig = "satz", snippetType = "autosnippet", condition = line_begin }, fmt(
        [[
\begin{satz}{<>}{<>}
    <>
\end{satz}
        ]],
        { i(1, "Titel"), i(2, "label"), i(0) },
        { delimiters = "<>" }
    )),
    s({ trig = "prop", snippetType = "autosnippet", condition = line_begin }, fmt(
        [[
\begin{proposition}{<>}{<>}
    <>
\end{proposition}
        ]],
        { i(1, "Titel"), i(2, "label"), i(0) },
        { delimiters = "<>" }
    )),
    s({ trig = "folg", snippetType = "autosnippet", condition = line_begin }, fmt(
        [[
\begin{fol}{<>}{<>}
    <>
\end{folgerung}
        ]],
        { i(1, "Titel"), i(2, "label"), i(0) },
        { delimiters = "<>" }
    )),
    s({ trig = "bsp", snippetType = "autosnippet", condition = line_begin }, fmt(
        [[
\begin{beispiel}{<>}{}
    <>
\end{beispiel}
        ]],
        { i(1, ""), i(0) },
        { delimiters = "<>" }
    )),
    s({ trig = "bem", snippetType = "autosnippet", condition = line_begin }, fmt(
        [[
\begin{bemerkung}{<>}{}
    <>
\end{bemerkung}
        ]],
        { i(1, ""), i(0) },
        { delimiters = "<>" }
    )),
    s({ trig = "beg", snippetType = "autosnippet", condition = line_begin }, fmt(
        [[
\begin{<>}
    <>
\end{<>}
        ]],
        { i(1, "env"), i(0), rep(1) },
        { delimiters = "<>" }
    )),
}
