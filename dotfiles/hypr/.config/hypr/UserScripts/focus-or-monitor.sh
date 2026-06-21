#!/usr/bin/env bash
set -euo pipefail

dir="${1:-}"
if [[ -z "$dir" ]]; then
  exit 2
fi

warp_to_active_window_center() {
  local x y
  if ! x="$(hyprctl activewindow -j | jq -er '.at[0] + (.size[0] / 2 | floor)')" ||
     ! y="$(hyprctl activewindow -j | jq -er '.at[1] + (.size[1] / 2 | floor)')"; then
    return 1
  fi
  hyprctl dispatch movecursor "$x" "$y" >/dev/null 2>&1 || true
}

warp_to_focused_monitor_center() {
  local x y
  if ! x="$(hyprctl monitors -j | jq -er '.[] | select(.focused == true) | .x + (.width / 2 | floor)')" ||
     ! y="$(hyprctl monitors -j | jq -er '.[] | select(.focused == true) | .y + (.height / 2 | floor)')"; then
    return 1
  fi
  hyprctl dispatch movecursor "$x" "$y" >/dev/null 2>&1 || true
}

before="$(hyprctl activewindow -j | jq -r '.address // ""')"
hyprctl dispatch movefocus "$dir" >/dev/null 2>&1 || true
after="$(hyprctl activewindow -j | jq -r '.address // ""')"

if [[ "$before" == "$after" ]]; then
  hyprctl dispatch focusmonitor "$dir" >/dev/null 2>&1 || true
fi

warp_to_active_window_center || warp_to_focused_monitor_center || true
