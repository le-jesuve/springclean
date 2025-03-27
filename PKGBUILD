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
sha256sums=('cbb7c6e7ccedb7061bd7454cb1e64c653e1f8ca2b1f66ba6602427e8d5486f34')

package() {
  install -Dm755 springclean.sh "$pkgdir/usr/bin/springclean"

  install -Dm644 /dev/null "$pkgdir/etc/xdg/springclean.conf"

  sed -i '2i\SYSCONFIG="/etc/xdg/springclean.conf"' "$pkgdir/usr/bin/springclean"
}
