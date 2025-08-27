#!/bin/sh

# Maintainer : artist for XLibre
# Script     : install-xlibre.sh
# Version    : 0.1
# Repository : To be used only together with the xlibre binary arch repo:
#                 https://github.com/X11Libre/binpkg-arch-based

# To run this script:
# - save it as file: install-xlibre.sh
# - run command: chmod +x install-xlibre.sh
# - run command: ./install-xlibre.sh
# Note: this script requires 'sudo' to perform the installation

if ! pacman-key -f 73580DE2EDDFA6D6  1> /dev/null 2>&1 ; then
  echo ""
  echo "Adding pacman key"
  sudo curl -sS https://raw.githubusercontent.com/X11Libre/binpkg-arch-based/refs/heads/main/0x73580DE2EDDFA6D6.gpg | gpg --import -
  sudo pacman-key --lsign-key 73580DE2EDDFA6D6
  sudo pacman-key --lsign-key artist@artixlinux.org
fi

if ! grep -q '\[xlibre\]' /etc/pacman.conf ; then
  echo ""
  echo "Adding the xlibre repository to file /etc/pacman.conf"
  sudo sh -c "echo [xlibre] >> /etc/pacman.conf"
  sudo sh -c "echo Server = https://github.com/X11Libre/binpkg-arch-based/raw/refs/heads/main/ >> /etc/pacman.conf"
fi 

echo ""
echo "Refreshing pacman database caches"
sudo pacman -Sy

echo ""
echo "Checking which XLibre packages to install to replace Xorg"
xlbpkgs="xlibre-xserver"
xlbxf86pkgs="xlibre-xf86-input-libinput"

xorgpkgs=$(pacman -Qq|grep '^xorg-server')
for p in $xorgpkgs ; do
  if [[ "$p" != "xorg-server" ]]; then
    xlbpkgs="$xlbpkgs ${p/xorg-/xlibre-x}"
  fi
done

xf86pkgs=$(pacman -Qq|grep '^xf86-')
for p in $xf86pkgs ; do
  if [[ "$p" != "xf86-input-libinput" ]]; then
    xlbxf86pkgs="$xlbxf86pkgs ${p/xf86-/xlibre-xf86-}"
  fi
done

xlballpkgs="$xlbpkgs $xlbxf86pkgs"

echo ""
echo "Running pacman to install all required XLibre packages"
echo "Enter Y for each package to replace it with the xlibre package"
sudo pacman -S $xlballpkgs
