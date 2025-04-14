# mkinitcpio-hook-neoshy

[![AUR](https://img.shields.io/aur/version/mkinitcpio-hook-neoshy.svg)](https://aur.archlinux.org/packages/mkinitcpio-hook-neoshy)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Build](https://img.shields.io/badge/build-makepkg-brightgreen)](#)
[![Shell Style](https://img.shields.io/badge/style-posix--ash-yellow)](#)

👉 [README in Russian](README-ru.md)

Custom mkinitcpio hook to mount a container image from a block device before running the `encrypt` hook.

---

## 💡 What it does

This hook is designed for setups where your encrypted root filesystem is stored *inside a container file* on a block device, not on the device itself.

It performs the following steps:

1. Mounts the block device specified by `src_dev=...`
2. Locates the container image via `src_img=...`
3. Attaches it to a loop device
4. Makes the loop device accessible to the `encrypt` hook via `cryptdevice=...`

---

## 🧵 Kernel cmdline usage

You must add the following parameters to your kernel cmdline:

```
src_dev=/dev/your_block_device src_img=/relative/path/to/container.img cryptdevice=/dev/loop0:your_crypt_name root=/dev/mapper/your_crypt_name
```

### Example

```
src_dev=/dev/nvme0n1p3 src_img=/crypto/rootfs.img cryptdevice=/dev/loop0:cryptroot cryptkey=/dev/sda5:0:3214325 crypto:::: root=/dev/mapper/cryptroot rw initrd=/Arch/initramfs-linux.img
```

> **Note:** Parameters `cryptdevice`, `cryptkey`, and `crypto` are provided and handled by the `encrypt` hook. This project does not implement or alter their behavior.  
> For detailed information on how to use these parameters, refer to the [ArchWiki article on dm-crypt system configuration](https://wiki.archlinux.org/title/Dm-crypt/System_configuration).

> **Hint:** The loop device (`/dev/loop0`) is created by this hook when the container image is attached. In typical setups where no other loop devices are in use during early boot, this device will be `/dev/loop0`. You must pass that path to the `encrypt` hook via the `cryptdevice=...` parameter.

---

## 📦 Installation

### ✅ On Arch-based distros (AUR):

Install via your favorite AUR helper:

```bash
paru -S mkinitcpio-hook-neoshy
# or
yay -S mkinitcpio-hook-neoshy
```

Or manually:

```bash
git clone https://aur.archlinux.org/mkinitcpio-hook-neoshy.git
cd mkinitcpio-hook-neoshy
makepkg -si
```

### 💻 On other distros (manual install):

```bash
make install
```

---

## 🔧 Configuration

After installation, add `neoshy` before `encrypt` in your `/etc/mkinitcpio.conf` `HOOKS` array:

```bash
HOOKS=(base udev autodetect modconf block keyboard neoshy encrypt filesystems fsck)
```

Then rebuild your initramfs:

```bash
sudo mkinitcpio -P
```

---

## 📜 License

MIT

Maintainer: Andrei A. Bykov <andreiab9019@gmail.com>

---

## 📋 Changelog

See [CHANGELOG.md](CHANGELOG.md) for full release history.