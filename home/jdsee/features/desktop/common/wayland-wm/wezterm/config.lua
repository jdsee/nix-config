local config = wezterm.config_builder()

config.color_scheme = 'Tokyo Night'

config.font = wezterm.font 'Fira Code'
config.font_size = 17

config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.85
config.text_background_opacity = 0.95

config.window_padding = {
  left = 4,
  right = 2,
  top = 0,
  bottom = 0,
}

config.scrollback_lines = 3500
config.enable_scroll_bar = true
config.window_close_confirmation = 'AlwaysPrompt'

-- TODO: Much more to configure here

config.leader = { key = 'f', mods = 'CTRL' }
config.keys = {
  {
    key = config.leader.key,
    mods = 'LEADER|CTRL',
    action = wezterm.action { SendString = '\x01' }
  },
  {
    key = '%',
    mods = 'LEADER|SHIFT',
    action = wezterm.action { SplitVertical = { domain = 'CurrentPaneDomain' } }
  },
  {
    key = '"',
    mods = 'LEADER|SHIFT',
    action = wezterm.action { SplitHorizontal = { domain = 'CurrentPaneDomain' } }
  },
  {
    key = 's',
    mods = 'LEADER',
    action = wezterm.action { SplitVertical = { domain = 'CurrentPaneDomain' } }
  },
  {
    key = 'v',
    mods = 'LEADER',
    action = wezterm.action { SplitHorizontal = { domain = 'CurrentPaneDomain' } }
  },
  {
    key = 'o',
    mods = 'LEADER',
    action = 'TogglePaneZoomState'
  },
  {
    key = 'z',
    mods = 'LEADER',
    action = 'TogglePaneZoomState'
  },
  {
    key = 'c',
    mods = 'LEADER',
    action = wezterm.action { SpawnTab = 'CurrentPaneDomain' }
  },
  {
    key = 'h',
    mods = 'LEADER',
    action = wezterm.action { ActivatePaneDirection = 'Left' }
  },
  {
    key = 'j',
    mods = 'LEADER',
    action = wezterm.action { ActivatePaneDirection = 'Down' }
  },
  {
    key = 'k',
    mods = 'LEADER',
    action = wezterm.action { ActivatePaneDirection = 'Up' }
  },
  {
    key = 'l',
    mods = 'LEADER',
    action = wezterm.action { ActivatePaneDirection = 'Right' }
  },
  {
    key = 'H',
    mods = 'LEADER|SHIFT',
    action = wezterm.action { AdjustPaneSize = { 'Left', 5 } }
  },
  {
    key = 'J',
    mods = 'LEADER|SHIFT',
    action = wezterm.action { AdjustPaneSize = { 'Down', 5 } }
  },
  {
    key = 'K',
    mods = 'LEADER|SHIFT',
    action = wezterm.action { AdjustPaneSize = { 'Up', 5 } }
  },
  {
    key = 'L',
    mods = 'LEADER|SHIFT',
    action = wezterm.action { AdjustPaneSize = { 'Right', 5 } }
  },
  {
    key = 'n',
    mods = 'LEADER',
    action = wezterm.action { ActivateTabRelative = 1 }
  },
  {
    key = 'p',
    mods = 'LEADER',
    action = wezterm.action { ActivateTabRelative = -1 }
  },
  {
    key = '1',
    mods = 'LEADER',
    action = wezterm.action { ActivateTab = 0 }
  },
  {
    key = '2',
    mods = 'LEADER',
    action = wezterm.action { ActivateTab = 1 }
  },
  {
    key = '3',
    mods = 'LEADER',
    action = wezterm.action { ActivateTab = 2 }
  },
  {
    key = '4',
    mods = 'LEADER',
    action = wezterm.action { ActivateTab = 3 }
  },
  {
    key = '5',
    mods = 'LEADER',
    action = wezterm.action { ActivateTab = 4 }
  },
  {
    key = '6',
    mods = 'LEADER',
    action = wezterm.action { ActivateTab = 5 }
  },
  {
    key = '7',
    mods = 'LEADER',
    action = wezterm.action { ActivateTab = 6 }
  },
  {
    key = '8',
    mods = 'LEADER',
    action = wezterm.action { ActivateTab = 7 }
  },
  {
    key = '9',
    mods = 'LEADER',
    action = wezterm.action { ActivateTab = 8 }
  },
  {
    key = '&',
    mods = 'LEADER|SHIFT',
    action = wezterm.action { CloseCurrentTab = { confirm = true } }
  },
  {
    key = 'd',
    mods = 'LEADER',
    action = wezterm.action { CloseCurrentPane = { confirm = true } }
  },
  {
    key = 'x',
    mods = 'LEADER',
    action = wezterm.action { CloseCurrentPane = { confirm = true } }
  },
  {
    key = '[',
    mods = 'LEADER',
    action = wezterm.action.ActivateCopyMode
  },
}
return config
