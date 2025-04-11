# Maintainer: Andrei A. Bykoff <andrei.a.bykov@hotmail.com>
pkgname=mkinitcpio-hook-neoshy
pkgver=1.0
pkgrel=1
pkgdesc="Custom mkinitcpio hook to mount container file from block device before running encrypt-hook"
arch=('any')
url="https://github.com/andr31ab"
license=('MIT')
depends=('mkinitcpio')
source=('hook' 'install')
sha256sums=('SKIP' 'SKIP')

package() {
    install -Dm755 "$srcdir/hook" "$pkgdir/usr/lib/initcpio/hooks/neoshy"
    install -Dm755 "$srcdir/install" "$pkgdir/usr/lib/initcpio/install/neoshy"
}
