#! /usr/bin/env bash
if (( "$(hyprctl monitors -j | jq length)" > 1 )) ; then
  hyprctl keyword monitor "eDP-1, disable"
fi
