# MacOS Subsystem for Linux

MacSL utilizes QEMU, SSH, and Wezterm to deliver to Mac users an experience similar to WSL for Windows users.

## Installation

First, clone the repository:

```
git clone git@github.com:lucasmsoares96/MacSL.git .MacSL
cd .MacSL
```

Next, execute the first script on MacOS, the second on Ubuntu, and the third on MacOS.

#### 1. MacOS

```
sudo ./1-config-macos.sh
```

#### 2. Ubuntu

```
sudo ./2-config-ubuntu.sh
```

#### 3. MacOS

```
sudo ./3-config-macos.sh
```

## Usage

Now you can use MacSL in 3 ways:
1. running the `ubuntu` command in the Apple `Terminal` application
2. connecting via `ssh` through vscode (ssh -p 2222 localhost)
3. opening `Wezterm`

## References

### Commands

#### Creating the disk image with Ubuntu

```
qemu-img create -f qcow2 Ubuntu.img 250G
qemu-system-x86_64 \               
	-m 8G \                              
	-smp 6 \
	-cdrom ../Downloads/ubuntu-22.04.4-live-server-amd64.iso \
	-drive file=Ubuntu.img,if=virtio \
	-vga virtio \
	-display default,show-cursor=on \
	-usb \
	-device usb-tablet \
	-cpu host \
	-machine type=q35,accel=hvf
```

#### Managing MacOS processes

```
man launchd.plist
launchctl unload ~/Library/LaunchAgents/MacSL.plist
launchctl load ~/Library/LaunchAgents/MacSL.plist
```

### Links

1. <https://wiki.qemu.org/Documentation/Networking>
1. <https://www.qemu.org/docs/master/system/devices/net.html>
1. <https://wiki.qemu.org/Documentation/9psetup>
1. <https://www.launchd.info>
1. <https://superuser.com/questions/628169/how-to-share-a-directory-with-the-host-without-networking-in-qemu>
1. <https://superuser.com/questions/1838449/how-to-mount-a-mac-host-folder-on-a-qemu-guest-linux>
