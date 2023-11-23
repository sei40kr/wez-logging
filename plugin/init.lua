local M = {}

local wezterm = require("wezterm")

M.action = {
  CaptureViewport = wezterm.action_callback(function(window, pane)
    local dimensions = pane:get_dimensions()
    local mux_window = window:mux_window()
    local filename = string.format(
      "%s/wezterm-viewport-%s-%s-%s-%s.log",
      wezterm.home_dir,
      mux_window:get_workspace(),
      mux_window:window_id(),
      pane:pane_id(),
      wezterm.strftime("%Y%m%dT%H%M%S")
    )
    local text = pane:get_text_from_region(
      0,
      dimensions.physical_top,
      dimensions.cols - 1,
      dimensions.physical_top + dimensions.viewport_rows - 1
    )

    local f = io.open(filename, "w")

    if not f then
      wezterm.log_warn("Failed to open file for writing: " .. filename)
      return
    end

    f:write(text)
    f:close()

    window:toast_notification("wezterm", "Viewport saved to " .. filename)
  end),
  CaptureScrollback = wezterm.action_callback(function(window, pane)
    local dimensions = pane:get_dimensions()
    local mux_window = window:mux_window()
    local filename = string.format(
      "%s/wezterm-scrollback-%s-%s-%s-%s.log",
      wezterm.home_dir,
      mux_window:get_workspace(),
      mux_window:window_id(),
      pane:pane_id(),
      wezterm.strftime("%Y%m%dT%H%M%S")
    )
    local text = pane:get_text_from_region(0, 0, dimensions.cols - 1, dimensions.scrollback_rows - 1)

    local f = io.open(filename, "w")

    if not f then
      wezterm.log_warn("Failed to open file for writing: " .. filename)
      return
    end

    f:write(text)
    f:close()

    window:toast_notification("wezterm", "Scrollback saved to " .. filename)
  end),
}

return M
