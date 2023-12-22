local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.default_cursor_style = "BlinkingBlock"

config.window_padding = {
    left = 30,
    right = 30,
    top = 30,
    bottom = 30,
}

config.window_background_opacity = 1

config.colors = {
    background = "#181616"
}

config.font_size = 17
config.line_height = 1.4

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.window_decorations = "RESIZE"

local function is_vim(pane)
    local is_vim_env = pane:get_user_vars().IS_NVIM == 'true'
    if is_vim_env then
        return true
    end
    local process_name = string.gsub(pane:get_foreground_process_name(), '(.*[/\\])(.*)', '%2')
    return process_name == 'nvim' or process_name == 'vim'
end

local super_vim_keys_map = {
    s = utf8.char(0xAA),
    x = utf8.char(0xAB),
    b = utf8.char(0xAC),
    ['.'] = utf8.char(0xAD),
    o = utf8.char(0xAF),
}

local function bind_super_key_to_vim(key)
    return {
        key = key,
        mods = 'CMD',
        action = wezterm.action_callback(function(win, pane)
            local char = super_vim_keys_map[key]
            if char and is_vim(pane) then
                win:perform_action({
                    SendKey = { key = char, mods = nil },
                }, pane)
            else
                win:perform_action({
                    SendKey = { key = key, mods = 'CMD' },
                }, pane)
            end
        end)
    }
end

config.keys = {
    bind_super_key_to_vim('s'),
}

return config
