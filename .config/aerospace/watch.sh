#!/bin/bash
# 常驻监听 AeroSpace 窗口检测事件，延迟后触发自动布局
# 用外部进程（而非 exec-and-forget）执行，避免回调上下文的时序问题

while read -r _; do
  sleep 0.5
  /bin/bash "$HOME/.config/aerospace/autolayout.sh"
done < <(/opt/homebrew/bin/aerospace subscribe window-detected 2>/dev/null)
