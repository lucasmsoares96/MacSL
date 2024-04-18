#!/bin/zsh

/usr/local/bin/qemu-system-x86_64 \
	-machine type=q35,accel=hvf \
	-cpu host \
	-drive file=/Users/lucas/.MacSL/Ubuntu.img,if=virtio \
	-m 8G \
	-smp 4 \
	-vga virtio \
	-display default,show-cursor=on \
	-usb \
	-device usb-tablet \
        -nographic \
        -net nic \
        -net user,hostfwd=tcp::7474-:7474,hostfwd=tcp::7687-:7687,hostfwd=tcp::3000-:3000,hostfwd=tcp::2222-:22,hostfwd=tcp::8000-:8000 \
        -virtfs local,path=$HOME,mount_tag=share,security_model=mapped-xattr,id=share,fmode=0644,dmode=0755

# /usr/local/bin/qemu-system-x86_64 \
#         -M accel=hvf \
#         --cpu host \
#         -hda /Users/lucas/.debian/debian.img \
#         -m 8G \
#         -smp 4 \
#         -nographic \
#         -net nic \
#         -net user,hostfwd=tcp::3000-:3000,hostfwd=tcp::2222-:22,hostfwd=tcp::8000-:8000 \
#         -virtfs local,path=$HOME,mount_tag=share,security_model=mapped-xattr,id=share,fmode=0644,dmode=0755
        # -virtfs local,path=/Users/lucas/,mount_tag=share,security_model=passthrough,id=share
