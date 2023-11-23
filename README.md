# wez-logging

[WezTerm](https://wezfurlong.org/wezterm) port of [tmux-logging](https://github.com/tmux-plugins/tmux-logging)

wez-logging saves the contents of the WezTerm scrollback buffer to a file.

## Installation

Clone this repository into your `$XDG_CONFIG_HOME/wezterm` directory:

```sh
git clone https://github.com/sei40kr/wez-pain-control.git $XDG_CONFIG_HOME/wezterm
```

## Usage

```lua
local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- Add these lines:
local logging = require("wez-logging.plugin")
config.keys = {
    -- You can change the key bindings to whatever you like.
    { key = "p", mods = "LEADER|ALT|SHIFT", action = logging.action.CaptureScrollback },
    { key = "p", mods = "LEADER|ALT",       action = logging.action.CaptureViewport },
}

return config
```
