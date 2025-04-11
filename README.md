# mkinitcpio-hook-neoshy

[![AUR](https://img.shields.io/aur/version/mkinitcpio-hook-neoshy.svg)](https://aur.archlinux.org/packages/mkinitcpio-hook-neoshy)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Build](https://img.shields.io/badge/build-makepkg-brightgreen)](#)
[![Shell Style](https://img.shields.io/badge/style-posix--ash-yellow)](#)

Custom mkinitcpio hook to mount a container image from a block device before running the `encrypt` hook.

---

## 💡 What it does

This hook is intended for use cases where your encrypted root filesystem is stored *inside a container file* on a block device, rather than on the block device itself.

It:

1. Mounts the block device specified by `src_dev=...`
2. Locates the container image file on that device via `src_img=...`
3. Attaches it to a loop device
4. Makes the loop device available to the `encrypt` hook, via standard `cryptdevice=...` kernel parameter

---

## 🧵 Kernel cmdline usage

You must add the following parameters to your kernel cmdline:

src_dev=/dev/your_block_device src_img=/relative/path/to/container.img cryptdevice=/dev/loop0:your_crypt_name root=/dev/mapper/your_crypt_name


Example:

src_dev=/dev/nvme0n1p3 src_img=/crypto/rootfs.img cryptdevice=/dev/loop0:cryptroot root=/dev/mapper/cryptroot


---

## 📦 Installation

### ✅ On Arch-based distros (AUR):

Install via your favorite AUR helper:

```bash
paru -S mkinitcpio-hook-neoshy
# or
yay -S mkinitcpio-hook-neoshy

Or manually:

git clone https://aur.archlinux.org/mkinitcpio-hook-neoshy.git
cd mkinitcpio-hook-neoshy
makepkg -si

💻 On other distros (manual install):

make install

🔧 Configuration

After installation, add neoshy before encrypt in your /etc/mkinitcpio.conf HOOKS array:

HOOKS=(base udev autodetect modconf block keyboard neoshy encrypt filesystems fsck)

Then rebuild your initramfs:

sudo mkinitcpio -P

📜 License

MIT

Maintainer: Andrei A. Bykov <andrei.a.bykov@hotmail.com>
