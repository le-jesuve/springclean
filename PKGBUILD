# Maintainer: YourName <your@email.com>
pkgname=springclean
pkgver=1.0.0
pkgrel=1
pkgdesc="file reorganization tool to automatically sort loose files into subdirectories based on extension"
arch=('any')
url="https://github.com/le-jesuve/springclean"
license=('GPL3')
depends=('bash')
source=("$url/releases/download/v$pkgver/springclean.sh")
sha256sums=('456d9e3fd9f7553bdeaff27256cc35491deec0731ae3dcf2919e54b0c32ad9fc')

package() {
  install -Dm755 "$srcdir/springclean.sh" "$pkgdir/usr/bin/springclean"
  install -Dm644 /dev/null "$pkgdir/etc/xdg/springclean/config"
}
