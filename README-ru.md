# mkinitcpio-hook-neoshy (по-русски)

Кастомный хук для `mkinitcpio`, позволяющий примонтировать файл-контейнер с зашифрованной root-файловой системой, находящийся **на блочном устройстве**, ещё до выполнения хука `encrypt`.

---

## 💡 Что делает этот хук

Если у тебя root находится **внутри файла** (например, `rootfs.img`, `.crypt`, `whatever.img`), и этот файл лежит **на разделе**, то обычный `encrypt`-хук не сможет его расшифровать напрямую.

`neoshy` решает это следующим образом:

1. Монтирует раздел, указанный в параметре `src_dev=...`
2. Ищет файл-контейнер по пути, указанному в `src_img=...`
3. Подключает его через `losetup` (loop-устройство)
4. Делает это **до** `encrypt`, чтобы тот увидел `/dev/loop0` и спокойно его расшифровал

---

## 🧵 Пример параметров ядра

Добавь эти параметры в cmdline ядра:

src_dev=/dev/nvme0n1p3 src_img=/crypto/rootfs.img cryptdevice=/dev/loop0:cryptroot root=/dev/mapper/cryptroot


---

## 📦 Установка

### ✅ Arch / Artix (через AUR):

```bash
paru -S mkinitcpio-hook-neoshy
# или
yay -S mkinitcpio-hook-neoshy

💻 Ручная установка (на других дистрибутивах):

make install

⚙️ Настройка

Добавь neoshy перед encrypt в массив HOOKS в /etc/mkinitcpio.conf:

HOOKS=(base udev autodetect modconf block keyboard neoshy encrypt filesystems fsck)

И пересобери initramfs:

sudo mkinitcpio -P

📜 Лицензия

MIT

Автор: Андрей А. Быков
