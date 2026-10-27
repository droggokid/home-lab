-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- Disabled Chromium web-app shortcuts.
hl.unbind("SUPER + SHIFT + A") -- Previously ChatGPT
hl.unbind("SUPER + SHIFT + ALT + A") -- Previously Grok
hl.unbind("SUPER + SHIFT + C") -- Previously Calendar
hl.unbind("SUPER + SHIFT + E") -- Previously Email
hl.unbind("SUPER + SHIFT + ALT + E") -- Previously New email
hl.unbind("SUPER + SHIFT + Y") -- Previously YouTube
hl.unbind("SUPER + SHIFT + ALT + G") -- Previously WhatsApp
hl.unbind("SUPER + SHIFT + CTRL + G") -- Previously Google Messages
hl.unbind("SUPER + SHIFT + P") -- Previously Google Photos
hl.unbind("SUPER + SHIFT + S") -- Previously Google Maps
hl.unbind("SUPER + SHIFT + X") -- Previously X
hl.unbind("SUPER + SHIFT + ALT + X") -- Previously X Post
