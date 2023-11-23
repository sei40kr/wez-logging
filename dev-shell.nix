{ mkShell, wezterm, wez-logging, writeTextFile }:

let
  config = writeTextFile {
    name = "wez-logging-dev-shell-config.lua";
    text = ''
      package.path = package.path .. ";${wez-logging}/?.lua"

      local wezterm = require("wezterm")

      local config = {}

      if wezterm.config_builder then
        config = wezterm.config_builder()
      end

      config.leader = { key = "b", mods = "CTRL" }

      config.keys = {
        { key = "p", mods = "LEADER|ALT|SHIFT", action = require("plugin").action.CaptureScrollback },
        { key = "p", mods = "LEADER|ALT",       action = require("plugin").action.CaptureViewport },
      }

      return config
    '';
  };
in
mkShell {
  name = "wez-logging-dev-shell";

  packages = [ wezterm ];

  shellHook = ''
    alias wezterm="wezterm --config-file ${config}"
  '';
}
