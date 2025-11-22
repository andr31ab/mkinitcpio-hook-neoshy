# mkinitcpio-hook-neoshy

[![AUR](https://img.shields.io/aur/version/mkinitcpio-hook-neoshy.svg)](https://aur.archlinux.org/packages/mkinitcpio-hook-neoshy)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Build](https://img.shields.io/badge/build-makepkg-brightgreen)](#)
[![Shell Style](https://img.shields.io/badge/style-posix--ash-yellow)](#)

👉 **README in Russian:** `README-ru.md`

---

## 💡 Overview

`mkinitcpio-hook-neoshy` is a custom mkinitcpio hook that prepares a containerized, encrypted root filesystem **before** the standard `encrypt` hook runs.

It supports **two boot modes**:

1. **Legacy Mode:**  
   Encrypted root filesystem stored inside a container file (`.img`, `.mkv`, etc.) located directly on the block device.

2. **Nested (“Matryoshka”) Mode — NEW:**  
   The container file resides on a **plain dm-crypt encrypted outer device**, such as an encrypted external HDD or SSD.  
   The hook unlocks the *outer* encrypted layer first, mounts it, locates the inner container file, and exposes it as a loop device for the `encrypt` hook to use.

---

## 🧩 Features

### ✔️ **Legacy Mode**
- Mounts a block device
- Locates a container file using `src_rootfs=<device>:<path>`
- Attaches it to `/dev/loop0`
- Passes it to the `encrypt` hook for inner decryption (`cryptdevice=/dev/loop0:root`)

### ✔️ **Nested Mode (“Matryoshka Mode”)**
- Unlocks an **outer** dm-crypt *plain* device using:
  - Password prompt
  - Custom crypto parameters (`outer_crypto=HASH:CIPHER:KEYSIZE:OFFSET`)
- Mounts the decrypted outer filesystem
- Locates the inner container (`src_rootfs=:<path/to/container>`)
- Sets up a loop device for the inner image
- Allows the standard `encrypt` hook to decrypt the *inner* root filesystem

---

## 🧵 Kernel Cmdline Parameters

### ### **Legacy Mode**
```
src_rootfs=<device_identifier>:/path/to/container.img cryptdevice=/dev/loop0:root root=/dev/mapper/root
```

### **Nested Mode (NEW)**
```
outer_device=<device_identifier> outer_crypto=<hash>:<cipher>:<keysize>:<offset> src_rootfs=:/path/to/inner-container.img cryptdevice=/dev/loop0:root cryptkey=<key_params> crypto=<inner_crypto_params> root=/dev/mapper/root
```

### Supported `<device_identifier>` formats
- `/dev/sdXY`
- `UUID=<uuid>`
- `PARTUUID=<partuuid>`
- `LABEL=<label>`
- `PARTLABEL=<partlabel>`

---

## 🔒 Nested Mode Cmdline Example

*(Device identifiers and offsets here are placeholders — adjust to your setup.)*

```
outer_device=UUID=XXXX-XXXX outer_crypto=sha256:aes-xts-plain64:256:123456 src_rootfs=:/secure/root/container.img cryptdevice=/dev/loop0:root cryptkey=PARTUUID=YYYYYYYY-YYYY-YYYY-YYYY-YYYYYYYYYYYY:offset:size crypto=sha256:aes-xts-plain64:512:600000:0 root=/dev/mapper/root rw
```

---

## 📦 Installation

### Arch Linux (AUR)
```
yay -S mkinitcpio-hook-neoshy
# or
paru -S mkinitcpio-hook-neoshy
```

### Manual
```
git clone https://aur.archlinux.org/mkinitcpio-hook-neoshy.git
cd mkinitcpio-hook-neoshy
makepkg -si
```

---

## 🔧 mkinitcpio Configuration

### Add the hook before `encrypt`:
```
HOOKS=(base udev autodetect modconf block keyboard neoshy encrypt filesystems fsck)
```

### Add required modules:
```
MODULES=(dm_mod dm_crypt loop xts aes sha256)
```

Rebuild initramfs:
```
sudo mkinitcpio -P
```

---

## 📜 License

MIT

Maintainer: Andrei A. Bykov <andreiab9019@gmail.com>

---

## 📋 Changelog

See `CHANGELOG.md` for full release notes.
