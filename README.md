# mkinitcpio-hook-neoshy

Custom mkinitcpio hook to mount a container image from a block device before running the `encrypt` hook.

## What it does

This hook is intended for use cases where your encrypted root filesystem is stored *inside a container file* on a block device, rather than on the block device itself.

It:

1. Mounts the block device specified by `src_dev=...`
2. Locates the container image file on that device via `src_img=...`
3. Attaches it to a loop device
4. Makes the loop device available to the `encrypt` hook, via standard `cryptdevice=...` kernel parameter

## Kernel cmdline usage

You must add the following parameters to your kernel cmdline:

src_dev=/dev/your_block_device src_img=/relative/path/to/container.img cryptdevice=/dev/loop0:your_crypt_name root=/dev/mapper/your_crypt_name

Example:

src_dev=/dev/nvme0n1p3 src_img=/crypto/rootfs.img cryptdevice=/dev/loop0:cryptroot root=/dev/mapper/cryptroot

## Installation

paru -S mkinitcpio-hook-neoshy (Of cause you can use another aur-helper :) )

Then add `neoshy` **before** `encrypt` in your `/etc/mkinitcpio.conf` HOOKS-section:

HOOKS=(base udev autodetect modconf block keyboard `neoshy` `encrypt` filesystems fsck)

Then rebuild your initramfs:

sudo mkinitcpio -P

## License

MIT

---
Author: Andrei A. Bykov <andrei.a.bykov@hotmail.com>

