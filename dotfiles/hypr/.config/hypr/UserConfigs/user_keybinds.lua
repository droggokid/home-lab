-- ==================================================
--  KoolDots (2026)
--  Project URL: https://github.com/LinuxBeginnings
--  License: GNU GPLv3
--  SPDX-License-Identifier: GPL-3.0-or-later
-- ==================================================

-- User keybind overrides (auto-generated).
-- Add keybinds with bind("MODS", "KEY", fn, opts).
-- Example:
-- bind("SUPER", "Z", exec_cmd("ghostty"), { description = "Launch ghostty" })
-- Helper functions live in ${XDG_CONFIG_HOME:-$HOME/.config}/hypr/lua/user_keybinds_helper.lua so they can be updated separately.
local user_keybinds_helper = nil
do
  local source = (debug.getinfo(1, "S") or {}).source or ""
  local source_path = source:match("^@(.+)$")
  local source_dir = source_path and source_path:match("^(.*)/[^/]+$") or nil
  local home = os.getenv("HOME") or ""
  local candidate_paths = {
    source_dir and (source_dir .. "/../lua/user_keybinds_helper.lua") or nil,
    home ~= "" and (home .. "/.config/hypr/lua/user_keybinds_helper.lua") or nil,
    home ~= "" and (home .. "/.config/hypr/user_keybinds_helper.lua") or nil,
  }

  local tried_paths = {}
  for _, helper_path in ipairs(candidate_paths) do
    if helper_path then
      table.insert(tried_paths, helper_path)
      local f = io.open(helper_path, "r")
      if f then
        f:close()
        local loaded_ok, loaded_helpers = pcall(dofile, helper_path)
        if loaded_ok and type(loaded_helpers) == "table" and loaded_helpers.bind then
          user_keybinds_helper = loaded_helpers
          break
        end
      end
    end
  end

  if not user_keybinds_helper then
    error("Failed to load user_keybinds_helper.lua from: " .. table.concat(tried_paths, ", "))
  end
end
local exec_cmd = user_keybinds_helper.exec_cmd
local dispatch = user_keybinds_helper.dispatch
local bind = user_keybinds_helper.bind
local unbind = user_keybinds_helper.unbind

-- Converted from UserKeybinds.conf
unbind("SUPER", "left")
unbind("SUPER", "right")
unbind("SUPER", "up")
unbind("SUPER", "down")
bind("SUPER", "left", exec_cmd("$HOME/.config/hypr/UserScripts/focus-or-monitor.sh l"), { description = "focus left or monitor left" })
bind("SUPER", "right", exec_cmd("$HOME/.config/hypr/UserScripts/focus-or-monitor.sh r"), { description = "focus right or monitor right" })
bind("SUPER", "up", exec_cmd("$HOME/.config/hypr/UserScripts/focus-or-monitor.sh u"), { description = "focus up or monitor up" })
bind("SUPER", "down", exec_cmd("$HOME/.config/hypr/UserScripts/focus-or-monitor.sh d"), { description = "focus down or monitor down" })
