# Maintainer: Andrei A. Bykov <andreiab9019@gmail.com>
pkgname=mkinitcpio-hook-neoshy
pkgver=1.0
pkgrel=2
pkgdesc="Custom mkinitcpio hook to mount container file from block device before running encrypt-hook"
arch=('any')
url="https://github.com/andr31ab/mkinitcpio-hook-neoshy"
license=('MIT')
depends=('mkinitcpio' 'cryptsetup')
source=('hook' 'install' 'README.md' 'README-ru.md' 'CHANGELOG.md')
sha256sums=(
	'd39cf974483f6879b7501a8cf4445069a727bf39b40863b4a07bb4c4daef1c70'
	'9031dc358ae5ac9f79117afa9735b4ae318eeeda63c9a8f46b154bdc6c4b369c'
	'47ca0b83451cd82b48551f30ca3f9f1f7c80968d6d0a068b3cc4046039c328fb'
	'50d0aa8339bbe47a0624dd3bdd14ad7f3568662b276ba579ba2f184ba246c814'
	'c8b8b505317fe5c1c7793c3d01f797aa6b46c907ad507112fde6c949564adfab')

package() {
    install -Dm755 "$srcdir/hook" "$pkgdir/usr/lib/initcpio/hooks/neoshy"
    install -Dm755 "$srcdir/install" "$pkgdir/usr/lib/initcpio/install/neoshy"
	install -Dm644 "$srcdir/README.md" "$pkgdir/usr/share/doc/$pkgname/README.md"
	install -Dm644 "$srcdir/CHANGELOG.md" "$pkgdir/usr/share/doc/$pkgname/CHANGELOG.md"
}
