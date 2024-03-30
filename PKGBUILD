# Maintainer: Alexander Sulfrian <asulfrian at zedat dot fu-berlin dot de>
# Contributor: swearchnick <swearchnick at gmail dot com>

_pkgname=linux_media
_gitname=media_build
_pkgbase="tbs-$_pkgname-git"
pkgname="$_pkgbase-dkms"
pkgver=r1590.8876436_c3c0c45
pkgrel=1
pkgdesc="TBS linux open source drivers (DKMS)"
arch=('x86_64')
url="https://github.com/tbsdtv/linux_media"
license=('GPL2')
makedepends=('git')
depends=('tbs-firmware' 'dkms' 'patchutils' 'perl-proc-processtable')
conflicts=('tbs-dvb-drivers')
provides=("$_pkgname")
source=('dkms.conf'
        'modules.list')
sha256sums=('c3b471b6c1556cd681f28b720b2ec3122994f77c9fa339985d1ca631b0c6e0bc'
            '195c6a971c915855ab4e39cfd4d7ae14b513fbb7c8daa5b3e5135cc5b50ba81c')

prepare() {

    git clone https://github.com/tbsdtv/$_gitname.git
    git clone --depth=1 https://github.com/tbsdtv/$_pkgname.git -b latest "$srcdir/media"

}

pkgver() {

    cd "$srcdir/$_gitname"
    _gitver=$(printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short=7 HEAD)")"_"

    cd "$srcdir/media"
    _gitver+=$(printf "%s" "$(git rev-parse --short=7 HEAD)")"_"

    echo "$_gitver"

}

package() {
    # Copy dkms.conf
    install -Dm644 "${srcdir}/dkms.conf" "${pkgdir}/usr/src/${_pkgbase}-${pkgver}/dkms.conf"

    # Set name and version
    sed -e "s/@_PKGBASE@/${_pkgbase}/" \
        -e "s/@PKGVER@/${pkgver}/" \
        -i "${pkgdir}/usr/src/${_pkgbase}-${pkgver}/dkms.conf"

    # Append module list
    cat "${srcdir}/modules.list" >> "${pkgdir}/usr/src/${_pkgbase}-${pkgver}/dkms.conf"

    # Copy sources
    mkdir -p "${pkgdir}/usr/src/${_pkgbase}-${pkgver}/media/"
    cp -r "${srcdir}/media"/* "${pkgdir}/usr/src/${_pkgbase}-${pkgver}/media/"

    mkdir -p "${pkgdir}/usr/src/${_pkgbase}-${pkgver}/media_build/"
    cp -r "${srcdir}/media_build"/* "${pkgdir}/usr/src/${_pkgbase}-${pkgver}/media_build/"
}
