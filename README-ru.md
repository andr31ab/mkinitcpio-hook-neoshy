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

1. Монтирует блочное устройство, указанное в `src_rootfs=...`
2. Находит в нём контейнерный файл
3. Подключает его к loop-устройству
4. Передаёт loop-устройство в хук `encrypt` через параметр `cryptdevice=...`

---

## 🧵 Использование в параметрах ядра

Необходимо добавить в командную строку ядра следующий параметр:

```
src_rootfs=<идентификатор_устройства>:/путь/до/образа.img cryptdevice=/dev/loop0:your_crypt_name root=/dev/mapper/your_crypt_name
```

Поддерживаемые форматы `<идентификатор_устройства>`:
- `/dev/sdXY`
- `UUID=<uuid>`
- `PARTUUID=<partuuid>`
- `LABEL=<label>`
- `PARTLABEL=<partlabel>`

### Пример

```
src_rootfs=UUID=aaaaaaaa-1111-bbbb-2222-cccccccccccc:/crypto/rootfs.img cryptdevice=/dev/loop0:cryptroot cryptkey=PARTUUID=00000000-xxxx-yyyy-9999-777777777777:ext4:/keyfile crypto:::: root=/dev/mapper/cryptroot rw initrd=\Arch\initramfs-linux.img
```

> **Важно:** Параметры `cryptdevice`, `cryptkey` и `crypto` относятся к хуку `encrypt` и обрабатываются исключительно им. Хук `neoshy` не влияет на их поведение.  
> Подробнее смотри в [статье ArchWiki по настройке dm-crypt](https://wiki.archlinux.org/title/Dm-crypt/System_configuration).

> **Подсказка:** Устройство `/dev/loop0` создаётся этим хуком при подключении контейнера.

---

## 📦 Установка

### ✅ В дистрибутивах на базе Arch (AUR):

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

Также может потребоваться добавить модули в массив `MODULES`:

```bash
MODULES=(<ваши_модули> dm_mod dm_crypt xts sha256)
```

Пересоберите initramfs:

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
