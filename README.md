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

\
_artist for Xlibre_

