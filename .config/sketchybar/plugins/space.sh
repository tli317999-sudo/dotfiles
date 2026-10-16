#!/bin/bash

update() {
  source "$CONFIG_DIR/colors.sh"
  # SketchyBar 在较新 macOS 上无法自动检测 Space，改为向 AeroSpace 查询当前 workspace
  FOCUSED_WS="$(aerospace list-workspaces --focused 2>/dev/null)"
  if [ "$FOCUSED_WS" = "$SID" ]; then
    SELECTED="true"
  else
    SELECTED="false"
  fi
  COLOR=$BACKGROUND_2
  if [ "$SELECTED" = "true" ]; then
    COLOR=$GREY
  fi
  sketchybar --set "$NAME" icon.highlight="$SELECTED" \
                         label.highlight="$SELECTED" \
                         background.border_color="$COLOR"
}

mouse_clicked() {
  aerospace workspace "$SID" 2>/dev/null
  sketchybar --trigger space_change
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  *) update
  ;;
esac
