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
sha256sums=('da2d70d3cf04155420e9d91611e938a40a174cf75aacf4517155483670a13ee1')

package() {
  install -Dm755 springclean.sh "$pkgdir/usr/bin/springclean"

  install -Dm644 /dev/null "$pkgdir/etc/xdg/springclean/springclean.conf"

  sed -i '2i\SYSCONFIG="/etc/xdg/springclean/springclean.conf"' "$pkgdir/usr/bin/springclean"
}
