# mkinitcpio-hook-neoshy

[![AUR](https://img.shields.io/aur/version/mkinitcpio-hook-neoshy.svg)](https://aur.archlinux.org/packages/mkinitcpio-hook-neoshy)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Build](https://img.shields.io/badge/build-makepkg-brightgreen)](#)
[![Shell Style](https://img.shields.io/badge/style-posix--ash-yellow)](#)

👉 [README in English](README.md)

Пользовательский хук для `mkinitcpio`, предназначенный для монтирования образа-контейнера с блочного устройства перед запуском хука `encrypt`.

---

## 💡 Что делает этот хук

Этот хук предназначен для сценариев, в которых зашифрованная корневая файловая система хранится *внутри контейнерного файла* на блочном устройстве, а не напрямую на устройстве.

Он выполняет следующие действия:

1. Монтирует указанное блочное устройство (`src_dev=...`)
2. Находит файл контейнера по пути `src_img=...`
3. Подключает его к loop-устройству
4. Передаёт loop-устройство в хук `encrypt` через параметр `cryptdevice=...`

---

## 🧵 Использование в параметрах ядра

Необходимо добавить в командную строку ядра следующие параметры:

```
src_dev=/dev/your_block_device src_img=/relative/path/to/container.img cryptdevice=/dev/loop0:your_crypt_name root=/dev/mapper/your_crypt_name
```

### Пример

```
src_dev=/dev/nvme0n1p3 src_img=/crypto/rootfs.img cryptdevice=/dev/loop0:cryptroot cryptkey=/dev/sda5:0:3214325 crypto:::: root=/dev/mapper/cryptroot rw initrd=/Arch/initramfs-linux.img
```

> **Важно:** Параметры `cryptdevice`, `cryptkey` и `crypto` относятся к хуку `encrypt` и обрабатываются исключительно им. Хук `neoshy` не влияет на их поведение.  
> Подробности по их использованию смотри в [статье ArchWiki по настройке dm-crypt](https://wiki.archlinux.org/title/Dm-crypt/System_configuration).

> **Подсказка:** Устройство `/dev/loop0` создаётся этим хуком при подключении контейнера. В большинстве систем, при условии отсутствия других loop-устройств на раннем этапе загрузки, будет использоваться именно `/dev/loop0`. Именно этот путь и следует указывать в `cryptdevice=...`.

---

## 📦 Установка

### ✅ В дистрибутивах на базе Arch (AUR):

Через помощника AUR:

```bash
paru -S mkinitcpio-hook-neoshy
# или
yay -S mkinitcpio-hook-neoshy
```

Или вручную:

```bash
git clone https://aur.archlinux.org/mkinitcpio-hook-neoshy.git
cd mkinitcpio-hook-neoshy
makepkg -si
```

### 💻 В других дистрибутивах (ручная установка):

```bash
make install
```

---

## 🔧 Настройка

После установки добавь `neoshy` перед `encrypt` в массив `HOOKS` в `/etc/mkinitcpio.conf`:

```bash
HOOKS=(base udev autodetect modconf block keyboard neoshy encrypt filesystems fsck)
```

Затем пересобери initramfs:

```bash
sudo mkinitcpio -P
```

---

## 📜 Лицензия

MIT

Мейнтейнер: Andrei A. Bykov <andreiab9019@gmail.com>

---

## 📋 История изменений

См. [CHANGELOG.md](CHANGELOG.md) для просмотра всех версий.