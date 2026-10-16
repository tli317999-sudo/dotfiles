# dotfiles

My personal macOS configuration for [SketchyBar](https://github.com/FelixKratz/SketchyBar) and [AeroSpace](https://github.com/nikitabobko/AeroSpace).

## Overview

- **SketchyBar** — a minimalist status bar with a translucent background
- **AeroSpace** — an i3-style tiling window manager
- **Auto-layout** — windows automatically tile into a grid as you open them

## Contents

```
.config/
  sketchybar/        # SketchyBar config (colors, icons, items, plugins)
  aerospace/         # auto-layout scripts (autolayout.sh, watch.sh)
.aerospace.toml      # AeroSpace main config
```

## Dependencies

Install with Homebrew:

```bash
brew tap FelixKratz/formulae
brew install sketchybar
brew install --cask sf-symbols
brew install jq switchaudio-osx
brew install --cask nikitabobko/tap/aerospace
```

Download the SketchyBar app-icon font:

```bash
curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.4/sketchybar-app-font.ttf \
  -o "$HOME/Library/Fonts/sketchybar-app-font.ttf"
```

## Installation

Clone the repo and symlink the configs into place:

```bash
git clone https://github.com/tli317999-sudo/dotfiles.git ~/dotfiles
mkdir -p ~/.config
ln -sfn ~/dotfiles/.config/sketchybar ~/.config/sketchybar
ln -sfn ~/dotfiles/.config/aerospace  ~/.config/aerospace
ln -sf ~/dotfiles/.aerospace.toml     ~/.aerospace.toml
```

Start SketchyBar:

```bash
brew services start sketchybar
```

Enable the auto-layout watcher so it survives reboots (a LaunchAgent that runs `watch.sh`):

```bash
mkdir -p ~/Library/LaunchAgents
cat > ~/Library/LaunchAgents/com.user.aerospace-autolayout.plist <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.user.aerospace-autolayout</string>
    <key>ProgramArguments</key>
    <array>
        <string>REPLACE_WITH_HOME/.config/aerospace/watch.sh</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
</dict>
</plist>
EOF
# replace REPLACE_WITH_HOME with your real home path, e.g. /Users/you
launchctl load ~/Library/LaunchAgents/com.user.aerospace-autolayout.plist
```

## Auto-layout behavior

Opening windows automatically arranges them into a grid:

| Tiling windows | Layout |
|---|---|
| 2 | side by side |
| 3 | 2 on top, 1 full-width below |
| 4 | 2×2 grid |

Floating windows (dialogs, etc.) are excluded and don't affect the tiling.

`watch.sh` listens to AeroSpace's `window-detected` event and runs `autolayout.sh`.

## Keybindings (AeroSpace defaults)

| Keys | Action |
|---|---|
| `alt + h/j/k/l` | focus window (left/down/up/right) |
| `alt + shift + h/j/k/l` | move window |
| `alt + 1…9` | focus workspace |
| `alt + shift + 1…9` | move window to workspace |
| `alt + shift + space` | toggle floating / tiling |
| `alt + /` | toggle tiling orientation |

## Credits & License

- SketchyBar config based on [Fireond/dotfiles](https://github.com/Fireond/dotfiles)
- SketchyBar config: GPL-3.0 (derived files) / MIT (original files)
- AeroSpace config: MIT
