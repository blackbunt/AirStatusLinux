# Maintainer: Mansour Behabadi <mansour@oxplot.com>
# modified by blackbunt

pkgname=airstatus-git
pkgver=20230124.b123b95
pkgrel=1
pkgdesc="Check AirPods battery levels on Linux"
arch=('i686' 'x86_64')
url="https://github.com/blackbunt/AirStatusLinux"
license=('GPL')
depends=('python36' 'python-bleak')
makedepends=('git')
provides=('airstatus')
conflicts=('airstatus')
source=("git+https://github.com/blackbunt/AirStatusLinux.git"
        "airstatus.service"
        "time_ns.py"
        )
sha256sums=('SKIP'
            '13ea0ae4760febf5b5f01cc2c64e39ede61ba6cce3514d3c6e17cebe2b574ebc'
            'aad9238ddaae6de9cfe57e643485da440af65de9fd86140ed9a90e9b0ca533d7')

pkgver() {
  cd AirStatusLinux
  printf "%s.%s" "$(git show -s --format=%cs | tr -d -)" "$(git rev-parse --short HEAD)"
}

package() {
  install -Dm644 airstatus.service -t "${pkgdir}/usr/lib/systemd/system"

  cd AirStatusLinux
  install -Dm644 main.py "${pkgdir}/usr/lib/airstatus.py"
  install -Dm644 time_ns.py "${pkgdir}/usr/lib/time_ns.py"
  install -Dm644 LICENSE -t "${pkgdir}/usr/share/licenses/airstatus"
}
