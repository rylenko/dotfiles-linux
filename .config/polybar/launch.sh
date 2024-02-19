#!/usr/bin/env sh

pkill polybar
while pgrep -x polybar >/dev/null; do sleep 0.5; done
polybar -c ~/.config/polybar/laptop-config.ini primary &
