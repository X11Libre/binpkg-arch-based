# XLibre x86_64 binary packages for Arch-based systems - https://x11libre.net/repo/arch_based

This repository provides [XLibre](https://github.com/X11Libre) x86_64 binary [third-party](https://wiki.archlinux.org/title/Unofficial_user_repositories) packages for [Arch Linux](https://archlinux.org)-based distributions. The primary location is [https://x11libre.net/repo/arch_based/x86_64](https://x11libre.net/repo/arch_based/x86_64). It is known to work with [Arch Linux](https://archlinux.org), [ArchCraft](https://archcraft.io), [CachyOS](https://cachyos.org), [EndeavourOS](https://endeavouros.com), [Garuda Linux](https://garudalinux.org), [Manjaro Linux](https://manjaro.org), [RebornOS](https://rebornos.org), and [SteamOS for PC](https://store.steampowered.com/steamos) up to version 3.8.

## Installing XLibre via Shell Script

There is a shell script [`install-xlibre.sh`](https://x11libre.net/repo/arch_based/x86_64/install-xlibre.sh) that guides you through the installation process and switching to XLibre. You can download and run it at the command line with either [`curl`](https://curl.se):

```shell
sh -c "$(curl -fsSL https://x11libre.net/repo/arch_based/x86_64/install-xlibre.sh)"
```

or [`wget`](https://www.gnu.org/software/wget):

```shell
sh -c "$(wget https://x11libre.net/repo/arch_based/x86_64/install-xlibre.sh -O -)"
```

## Installing XLibre Manually

### Adding the Public Package Signing Key to pacman

Add the public package signing key of the [OpenPGP](https://wiki.archlinux.org/title/OpenPGP) key used to [sign the packages](https://wiki.archlinux.org/title/Pacman/Package_signing) of this repository to the pacman keyring:

```shell
sudo pacman-key --recv-keys 73580DE2EDDFA6D6
sudo pacman-key --finger 73580DE2EDDFA6D6
sudo pacman-key --lsign-key 73580DE2EDDFA6D6
```

In case the above `pacman-key` commands fail, you can manually add the public key with either `curl`:

```shell
sudo sh -c 'curl -sS https://x11libre.net/repo/arch_based/x86_64/0x73580DE2EDDFA6D6.gpg | gpg --import -'
```

or `wget`:

```shell
sudo sh -c 'wget https://x11libre.net/repo/arch_based/x86_64/0x73580DE2EDDFA6D6.gpg -O - | gpg --import -'
```

### Adding the Repository to Pacman

Once you retrieved the public key, add an entry for the XLibre repository by adding this section to the file `/etc/pacman.conf`:

```ini
[xlibre]
Server = https://x11libre.net/repo/arch_based/x86_64
```

### Installing the XLibre Xserver and Drivers

There are two ways to install XLibre depending on whether the X.Org Server and its drivers are already installed on your system or not. In both cases you first need to install the `xlibre-server` and `xlibre-input-libinput` packages:

```shell
pacman -S xlibre-server xlibre-input-libinput
```

These packages will replace their X.Org counterparts. After doing so, use one of the two methods as follows.

#### Migrating from X.Org to XLibre

For migrating from X.Org to XLibre, you need to search for any installed X.Org driver packages and replace them with their XLibre counterparts:

```shell
pacman -Q | grep '^xorg-server-\|^xf86' | cut -d' ' -f1 | \
	sed 's/^xorg-server-/xlibre-xserver-/' | \
	sed 's/^xf86-/xlibre-/' | xargs -ro pacman -Syy
```

The above command queries `pacman` for any installed packages having `xf86-` in their name, replaces the `xf86-` prefix with `xlibre-`, and installs the XLibre counterparts. For example, an installed package `xf86-video-amdgpu` would be replaced by `xlibre-video-amdgpu`. By installing the `xlibre-` packages, the old `xf86-` packages will be removed automatically.

#### Installing XLibre On A Non-X.Org System

To install XLibre on a non-X.Org system, first install `xlibre-server` and `xlibre-input-libinput` as shown above. Then list the PCI VGA controllers on your machine via `lspci` and look for the appropriate drivers in the list of available XLibre video drivers:

```shell
lspci -v -nn -d ::03xx
pacman -Ss xlibre-video
```

Please see the [Driver Installation - Xorg - ArchWiki](https://wiki.archlinux.org/title/Xorg#Driver_installation) for more details. Additionally, some packages from the [xorg-apps](https://archlinux.org/groups/x86_64/xorg-apps/) group are necessary for certain configuration tasks. They are pointed out in the relevant sections of [Configuration - Xorg - ArchWiki](https://wiki.archlinux.org/title/Xorg#Configuration).

## TearFree Option

XLibre has the 'TearFree' option enabled by default since [commit 0dacee6](https://github.com/X11Libre/xserver/commit/0dacee6c5149b63a563e9bed63502da2e9f1ac1f), while Xorg does not.

## Closed-Source Drivers

Closed-source drivers might not yet have an updated ABI version to match that of the updated XLibre Xserver.
This can be overcome by creating a file named, e.g., `/etc/X11/xorg.conf.d/xlibre.conf` containing:

``` conf
Section "ServerFlags"
    Option "IgnoreABI" "true"
EndSection
```

For more information, please see the [Nvidia proprietary driver](https://github.com/X11Libre/xserver/wiki/Compatibility-of-XLibre#nvidia-proprietary-driver) section of [Compatibility of XLibre · X11Libre/xserver Wiki](https://github.com/X11Libre/xserver/wiki/Compatibility-of-XLibre).

## Contact

Please report any issues with this repository at [Issues · X11Libre/binpkg-arch-based](https://github.com/X11Libre/binpkg-arch-based/issues). In case you need help, want to report success or talk about other aspects of the build, just go to [X11Libre/packaging: XLibre On Arch Linux · Discussions · GitHub](https://github.com/X11Libre/packaging/discussions/categories/xlibre-on-arch-linux).

_artist for Xlibre_ (artist4xlibre at proton dot me)

