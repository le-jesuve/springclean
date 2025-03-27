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
sha256sums=('0d4c8e8ca1466b63fa87023c27fcafd5b78de37013e76d4a76ee62426e1653df')

package() {
  install -Dm755 "$srcdir/springclean.sh" "$pkgdir/usr/bin/springclean"
  install -Dm644 /dev/null "$pkgdir/etc/xdg/springclean/config"
}
