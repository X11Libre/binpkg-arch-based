Arch based Xlibre binary packages repository
--------------------------------------------

This repository can be enabled with the following actions:

* Run commands:\
  `sudo pacman-key --recv-keys 73580DE2EDDFA6D6`\
  `sudo pacman-key --finger 73580DE2EDDFA6D6`\
  `sudo pacman-key --lsign-key 73580DE2EDDFA6D6`
* Add the xlibre repository by adding this section to file /etc/pacman.conf:\
  `[xlibre]`\
  `Server = https://github.com/X11Libre/binpkg-arch-based/raw/refs/heads/main/`\
  `# List of available packages: https://github.com/artist4xlibre/packages-arch-based`


Attention: when migrating from Xorg package xlibre-input-libinputi-bin needs to be installed together with xlibre-server-bin and xlibre-server-common-bin.   
   The installation requires via pacman that for any currently installed xf86-(input/video) driver package the corresponding xlibre-(input/video) package needs to be installed.

If for example these packages are installed: xorg-server xorg-server-comon xf86-input-libinput xf86-video-amdgpu   
Then for XLibre install: xlibre-server-bin xlibre-server-common-bin xlibre-input-libinput xlibre-video-amdgpu-bin   
This will have pacman automatically remove the xorg/xf86 packages.


TearFree option
===============

Xlibre has the 'TearFree' option enabled by default, while Xorg does not.


Closed source drivers
=====================

Closed source drivers might not yet have an updated ABI version to match that of the updated xlibre-xserver.   
This can be overcome by creating a file named eg. /etc/X11/xorg.conf.d/xlibre.conf containing:

    `Section "ServerFlags"`\
    `    Option "IgnoreABI" "true"`\
    `EndSection`


\
_artist for Xlibre_

