# Maintainer: Andrei A. Bykov <andreiab9019@gmail.com>
pkgname=mkinitcpio-hook-neoshy
pkgver=1.2
pkgrel=1
pkgdesc="Custom mkinitcpio hook to mount container file from block device before running encrypt-hook"
arch=('any')
url="https://github.com/andr31ab/mkinitcpio-hook-neoshy"
license=('MIT')
depends=('mkinitcpio' 'cryptsetup')
source=('hook' 'install' 'README.md' 'README-ru.md' 'CHANGELOG.md')
sha256sums=(
	'ee2565a266693e3d17daafcb6b9b45af997f892d1d3b1e00cae85c14b00c2d2c'
	'3414397af335d5073e8bc479f1f163e6367aab0f5aad334f799f3c6cf315f0c5'
	'd0bd4ce9a9ae94f83b0eb4742c32b2aefbfecccdcdb168fcc619b850eaa796f9'
	'18c5effa27400a07e40433d86f3eb0f313f8ad1879f56ca932db04b19d18666a'
	'2753a088d3c423ff550947a060d8c68d4fcb49a7eafc58f05921781a4a00e482')

package() {
    install -Dm755 "$srcdir/hook" "$pkgdir/usr/lib/initcpio/hooks/neoshy"
    install -Dm755 "$srcdir/install" "$pkgdir/usr/lib/initcpio/install/neoshy"
	install -Dm644 "$srcdir/README.md" "$pkgdir/usr/share/doc/$pkgname/README.md"
	install -Dm644 "$srcdir/CHANGELOG.md" "$pkgdir/usr/share/doc/$pkgname/CHANGELOG.md"
}
