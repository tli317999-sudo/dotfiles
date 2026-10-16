#!/bin/bash
# AeroSpace 自动网格布局
#   2 个平铺窗口 -> 左右并列
#   3 个平铺窗口 -> 上 2 下 1
#   4 个平铺窗口 -> 2x2 田字
# 由 ~/.aerospace.toml 的 on-window-detected 回调触发
# 用 eval 一次性同步发送命令，避免逐个 CLI 调用的时序竞争

WS="$(aerospace list-workspaces --focused 2>/dev/null)"
[ -z "$WS" ] && exit 0

COUNT="$(aerospace list-windows --workspace "$WS" --format '%{window-layout}' 2>/dev/null | grep -vc '^floating$')"

case "$COUNT" in
  2)
    aerospace eval "flatten-workspace-tree; layout --workspace $WS --root horizontal" 2>/dev/null
    ;;
  3)
    aerospace eval "flatten-workspace-tree; layout --workspace $WS --root vertical; focus --dfs-index 0; join-with down" 2>/dev/null
    ;;
  4)
    aerospace eval "flatten-workspace-tree; layout --workspace $WS --root vertical; focus --dfs-index 0; join-with down; focus --dfs-index 2; join-with down" 2>/dev/null
    ;;
  *) exit 0 ;;
esac
