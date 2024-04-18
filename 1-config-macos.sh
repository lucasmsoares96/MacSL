#!/bin/sh

# Check if script is running with sudo
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root. Please use sudo."
    exit 1
fi

## Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (echo; echo 'eval "$(/usr/local/bin/brew shellenv)"') >> /Users/lucas/.zprofile\n    eval "$(/usr/local/bin/brew shellenv)"
brew tap homebrew/cask-versions
brew install --cask wezterm-nightly
brew install qemu neofetch zoxide

## Oh My Zsh
yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## Zoxide

cat >> /home/$USER/.zshrc << 'EOL'

eval "$(zoxide init zsh)"
EOL"
source ~/.zshrc

## Wezterm
mkdir -p $HOME/.config/wezterm/
touch $HOME/.config/wezterm/wezterm.lua
cat >> $HOME/.config/wezterm/wezterm.lua << 'EOL'
local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font 'JetBrains Mono'
-- config.color_scheme = 'Google Light (Gogh)'
config.default_prog = { '/usr/local/bin/ubuntu' }
config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = 'NeverPrompt'
config.skip_close_confirmation_for_processes_named = {
  'bash',
  'ssh',
  'sh',
  'zsh',
  'fish',
  'tmux',
  'nu',
  'cmd.exe',
  'pwsh.exe',
  'powershell.exe',
}


-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Google Dark (Gogh)'
  else
    return 'Google Light (Gogh)'
  end
end

config.color_scheme = scheme_for_appearance(get_appearance())

return config
EOL"
