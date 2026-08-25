-- ==================================================
--  KoolDots (2026)
--  Project URL: https://github.com/LinuxBeginnings
--  License: GNU GPLv3
--  SPDX-License-Identifier: GPL-3.0-or-later
-- ==================================================

-- System Laptops (auto-generated).
-- This file keeps migrated settings split from user overrides.
-- Add only Lua entries here.
-- Example:
-- hl.config({ general = { gaps_in = 4, gaps_out = 8 } })

-- Source reference from Laptops.conf (hyprlang):
-- $mainMod = SUPER
-- $scriptsDir = $HOME/.config/hypr/scripts
-- $UserConfigs = $HOME/.config/hypr/UserConfigs
-- $Touchpad_Device=asue1209:00-04f3:319f-touchpad
-- binde = , xf86KbdBrightnessDown, exec, $scriptsDir/BrightnessKbd.sh --dec # decrease keyboard brightness
-- binde = , xf86KbdBrightnessUp, exec, $scriptsDir/BrightnessKbd.sh --inc # increase keyboard brightness
-- binde = , xf86MonBrightnessDown, exec, $scriptsDir/Brightness.sh --dec # decrease monitor brightness
-- binde = , xf86MonBrightnessUp, exec, $scriptsDir/Brightness.sh --inc # increase monitor brightness
-- bind = , xf86TouchpadToggle, exec, $scriptsDir/TouchPad.sh # disable touchpad
-- bind = $mainMod, F6, exec, $scriptsDir/ScreenShot.sh --now # screenshot
-- bind = $mainMod SHIFT, F6, exec, $scriptsDir/ScreenShot.sh --area # screenshot (area)
-- bind = $mainMod CTRL, F6, exec, $scriptsDir/ScreenShot.sh --in5 # # screenshot (5 secs delay)
-- bind = $mainMod ALT, F6, exec, $scriptsDir/ScreenShot.sh --in10 # screenshot (10 secs delay)
-- bind = ALT, F6, exec, $scriptsDir/ScreenShot.sh --active # screenshot (active window only)
-- $TOUCHPAD_ENABLED = true
-- device {
-- name = $Touchpad_Device
-- enabled = $TOUCHPAD_ENABLED
-- }

hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/BrightnessKbd.sh --dec"), { repeating = true })
hl.bind("XF86KbdBrightnessUp", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/BrightnessKbd.sh --inc"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/Brightness.sh --dec"), { repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/Brightness.sh --inc"), { repeating = true })
hl.bind("XF86TouchpadToggle", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/TouchPad.sh"))

hl.bind("SUPER + F6", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/ScreenShot.sh --now"))
hl.bind("SUPER + SHIFT + F6", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/ScreenShot.sh --area"))
hl.bind("SUPER + CTRL + F6", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/ScreenShot.sh --in5"))
hl.bind("SUPER + ALT + F6", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/ScreenShot.sh --in10"))
hl.bind("ALT + F6", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/ScreenShot.sh --active"))

hl.device({ name = "asue1209:00-04f3:319f-touchpad", enabled = true })
