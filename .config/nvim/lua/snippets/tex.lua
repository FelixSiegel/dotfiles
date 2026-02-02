local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

-- Auto-expand subscripts: a_ij -> a_{ij}
local auto_subscript = s(
    {
        trig = "([%a%)%]%}])_(%w%w+)",
        regTrig = true,
        wordTrig = false,
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

-- Return: first table is regular snippets, second is autosnippets
return {}, {
    auto_subscript,
    auto_superscript,
    auto_negative_superscript,
    auto_negative_subscript,
    auto_frac,
}
