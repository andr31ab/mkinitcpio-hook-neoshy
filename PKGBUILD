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
	'de8b596eef5aca3b335e946cb09b8ea58497033e675ae1280683741857886591'
	'9031dc358ae5ac9f79117afa9735b4ae318eeeda63c9a8f46b154bdc6c4b369c'
	'b2c7fa753ac5d9abd82d6c6eb3b2e7ab6414785f754e4f4f1671f13df038f9fc'
	'614c5a823ab23b6d09c5081fb8ed300bb6dcc2b98ed9eeaf1bcb3cd3bbd2d1c7'
	'c8b8b505317fe5c1c7793c3d01f797aa6b46c907ad507112fde6c949564adfab')

package() {
    install -Dm755 "$srcdir/hook" "$pkgdir/usr/lib/initcpio/hooks/neoshy"
    install -Dm755 "$srcdir/install" "$pkgdir/usr/lib/initcpio/install/neoshy"
	install -Dm644 "$srcdir/README.md" "$pkgdir/usr/share/doc/$pkgname/README.md"
	install -Dm644 "$srcdir/CHANGELOG.md" "$pkgdir/usr/share/doc/$pkgname/CHANGELOG.md"
}
