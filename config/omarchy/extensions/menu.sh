#!/bin/bash
# User extension for omarchy-menu - overrides show_system_menu() to put Shutdown first

# Override the system menu function with Shutdown at the top
show_system_menu() {
  local options="󰐥  Shutdown"
  [ -f ~/.local/state/omarchy/toggles/suspend-on ] && options="$options\n󰒲  Suspend"
  omarchy-hibernation-available && options="$options\n󰤁  Hibernate"
  options="$options\n󰜉  Restart\n  Lock\n󱄄  Screensaver"

  case $(menu "System" "$options") in
  *Lock*) omarchy-lock-screen ;;
  *Screensaver*) omarchy-launch-screensaver force ;;
  *Suspend*) systemctl suspend ;;
  *Hibernate*) systemctl hibernate ;;
  *Restart*) omarchy-cmd-reboot ;;
  *Shutdown*) omarchy-cmd-shutdown ;;
  *) back_to show_main_menu ;;
  esac
}
