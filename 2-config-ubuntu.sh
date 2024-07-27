#!/bin/sh

# Check if script is running with sudo
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root. Please use sudo."
    exit 1
fi

# Ubuntu Configuration

apt update && apt full-upgrade -y && apt autopurge -y && apt clean
apt install libfuse2 fuse neofetch zip zsh git build-essential zoxide bindfs
touch ~/.hushlogin
dpkg-reconfigure locales
locale-gen
perl -e exit
mkdir /mnt/macos
mkdir Mac
ufw disable

cat >> /etc/fstab << 'EOL'
share                                                   /mnt/macos      9p      trans=virtio,version=9p2000.L,rw,_netdev,nofail     0   0
/mnt/macos                                              /home/lucas/Mac fuse.bindfs map=501/1000:@20/@1000,nonempty,x-systemd.requires=/mnt/macos,x-systemd.automount   0 0
EOL

## Oh My Zsh
# Sair de dentro do zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## Helix

wget https://github.com/helix-editor/helix/releases/download/24.03/helix-24.03-x86_64.AppImage
chmod +x helix-24.03-x86_64.AppImage
mv helix-24.03-x86_64.AppImage hx
mv hx /usr/local/bin

cat >> /home/$USER/.config/helix/config.toml << 'EOL'
theme = "onelight"

[editor]
line-number = "relative"
mouse = true
scrolloff = 55
true-color = true

[editor.cursor-shape]
insert = "bar"
normal = "block"
select = "underline"

[editor.file-picker]
hidden = false

# At most one section each of 'keys.normal', 'keys.insert' and 'keys.select'
[keys.normal]
C-s = ":w" # Maps Ctrl-s to the typable command :w which is an alias for :write (save file)

[keys.insert]
j = { k = "normal_mode" } # Maps jk to exit insert mode
EOL

## Node

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.zshrc
nvm install node
npm install -g typescript-language-server typescript


## Zoxide

cat >> /home/$USER/.zshrc << 'EOL'

eval "$(zoxide init zsh)"
EOL
source ~/.zshrc
