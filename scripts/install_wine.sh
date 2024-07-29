#!/bin/bash

#--------------------------------#
# import variables and functions #
#--------------------------------#
source ./scripts/functions.sh
if [ $? -ne 0 ]; then
  echo "Error: failed to source functions.sh, please execute from $(dirname $(realpath $0))..."
  exit 1
fi

#------------------#
# install wine-tkg #
#------------------#

# install wine-staging with all optional dependencies
chk_aurh
$aurhlpr -S wine-staging winetricks wine-mono giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader

# build wine-tkg with customized configs
git clone https://github.com/Frogging-Family/wine-tkg-git.git $GitPkgDir/wine-tkg-git/

sed -i -e 's/^_use_esync=\".*\"$/_use_esync="false"/
           s/^_use_fsync=\".*\"$/_use_fsync="true"/
           s/^_FS_bypass_compositor=\".*\"$/_FS_bypass_compositor="true"/
           s/^_proton_fs_hack=\".*\"$/_proton_fs_hack="true"/
           s/^_msvcrt_nativebuiltin=\".*\"$/_msvcrt_nativebuiltin="true"/
           s/^_win10_default=\".*\"$/_win10_default="true"/
           s/^_protonify=\".*\"$/_protonify="true"/' $GitPkgDir/wine-tkg-git/wine-tkg-git/customization.cfg
sed -i -e 's/^_GCC_FLAGS=\"/_GCC_FLAGS="-march=native\ /
           s/^_CROSS_FLAGS=\"/_CROSS_FLAGS=\"-march=native\ /' $GitPkgDir/wine-tkg-git/wine-tkg-git/wine-tkg-profiles/advanced-customization.cfg

makepkg -si

# set wine prefixes and create one for win64
unset DISPLAY
WINEPREFIX=$HOME/.wine WINEARCH=win64 winecfg &>/dev/null
WINEPREFIX=$HOME/.wine32 WINEARCH=win32

#--------------#
# install DXVK #
#--------------#

# build dxvk with customized configs
git clone https://github.com/loathingKernel/PKGBUILDs $GitPkgDir/PKGBUILDs/
sed -i -e 's/patch -p1 -i "$srcdir"\/1582\.patch//g
           s/patch -p1 -i "$srcdir"\/1582-fix-include\.patch//g
           s/-O3 -march=haswell -mtune=haswell -pipe/-O2 -march=native -mtune=native -pipe/g' $GitPkgDir/PKGBUILDs/public/dxvk-mingw/PKGBUILD
makepkg -si

# install dxvk to wine prefix
WINEPREFIX=$HOME/.wine setup_dxvk install

#----------------------#
# install vkd3d-proton #
#----------------------#

# build vkd3d with customized configs
git clone https://aur.archlinux.org/vkd3d-proton-mingw.git $GitPkgDir/vkd3d-proton-mingw/
sed -i 's/-O3 -march=nocona -mtune=core-avx2 -pipe/-O2 -march=native -mtune=native -pipe/g' $GitPkgDir/vkd3d-proton-mingw/PKGBUILD
makepkg -si

# install vkd3d to wine prefix
setup_vkd3d_proton install $HOME/.wine