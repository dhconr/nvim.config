local colors = {
    keyword = "#57B5F4",
    type = "#CB7676",
    string = "#CCB88F",
    ["function"] = "#EAB095",
    declaration = "#5D99A9",
    variable = "#BD976A",
    -- Add more colors as needed
}
local function set_highlight(group, color)
    local style = color.style and "gui=" .. color.style or "gui=NONE"
    local fg = color.fg and "guifg=" .. color.fg or "guifg=NONE"
    local bg = color.bg and "guibg=" .. color.bg or "guibg=NONE"
    local sp = color.sp and "guisp=" .. color.sp or ""
    local cmd = string.format("highlight %s %s %s %s %s", group, style, fg, bg, sp)
    vim.cmd(cmd)
end

local function apply_highlights()
    set_highlight("Keyword", {fg = colors.keyword})
    set_highlight("Type", {fg = colors.type})
    set_highlight("String", {fg = colors.string})
    set_highlight("Function", {fg = colors["function"]})
    set_highlight("Statement", {fg = colors.declaration})
    set_highlight("Variable", {fg = colors.variable})
    -- You can continue to define more highlights here
end

local function setup()
    -- Ensure that the background and foreground are to your liking
    vim.cmd("highlight clear")
    if vim.fn.exists("syntax_on") then
        vim.cmd("syntax reset")
    end
    vim.g.colors_name = "sveltesse"  -- Set the colorscheme name

    apply_highlights()
end

return {
    setup = setup
}

