# dotfiles

![NixOS](https://img.shields.io/badge/NIXOS-5277C3.svg?logo=NixOS&logoColor=white) [![xc compatible](https://xcfile.dev/badge.svg)](https://xcfile.dev) 

Full reproducable config for a mail server, 3D-printer controller, desktop, laptop, router, and a Raspberry Pi 5 server.

## Table of Contents

  * [Installation](#installation)
  * [Troubleshooting](#troubleshooting)
  * [Tasks](#tasks)

## Installation

### Boot from NixOS installation media

> [!TIP]
> Using the minimal installation media is recommended, as it is smaller and faster to download. However, you cannot use network manager (`nmtui`) to setup wireless networking with the minimal image.


### Set up internet

> [!NOTE]
> If you already have a wired connection, you can skip this step.

```bash
sudo systemctl start wpa_supplicant
sudo wpa_cli
> add_network
> set_network 0 ssid "your_ssid_here"
> set_network 0 psk "your_password_here"
> enable_network 0
> save_config
> quit
```

### Partition and format

> [!CAUTION]
> This deletes your data, check drive names carefully.

```bash
cfdisk /dev/drivename
```

Now, delete all partitions on the disk and create the new partitions:
  - A 525M "EFI System" partition,
  - a "Linux Swap" partition,
  - and a generic "Linux Filesystem" partition to fill the rest of the disk.

First, format the EFI System partition with FAT:

```bash
mkfs.fat -F 32 -n boot /dev/drivename1
```

Then, format the swap partition, giving it the label of 'swap':

```bash
mkswap -L swap /dev/drivename2
```

And finally, format the main Linux Filesystem partition with ext4, giving it the label of 'nixos':

```bash
mkfs.ext4 -L nixos /dev/drivename3
```

These drive labels are used by the system config in [fileSystems.nix](modules/nixos/fileSystems.nix) to avoid hardcoding drive UUIDs.

### Mount to edit.

To edit the contents of the disk, it needs to be mounted into a folder.
First, mount the main Linux Filesystem:

```bash
mount /dev/whatever3 /mnt # Mount root filesystem
```

Then, mount the boot filesystem:

```bash
mkdir -p /mnt/boot
mount /dev/whatever1 /mnt/boot # Mount boot partition
```

Finally, enable the swap:

```bash
swapon /dev/whatever2 # Use the swap partition
```


### First system install.

Generate example configuration as referance.
```bash
nixos-generate-config --root ./
```

> [!NOTE]
> Copy unique parts of the autogenerated `hardware-configuration.nix` to the `hardware.nix` of the system to ensure compatibilty with hardware.

Download this repo. This is stored in a tmpfs, so it will be lost on reboot.
```bash
nix-shell -p git
git clone https://github.com/headblockhead/dotfiles.git
```

> [!WARNING]
> Changes made to this copy of the dotfiles are not saved, so copy changes to the /mnt folder or other means of persistance to avoid pain later.

Build and install. Set a root password, it can be anything as we will disable direct root in a minute.
```bash
cd dotfiles
nixos-install --root /mnt --flake .#HOSTNAME
reboot
```

### Login to root

    Use a non-graphical shell to login as root, then set the user password.

    ```bash
    passwd headb
    ```

### Final steps.

  Lock root account from login:
  ```bash
  sudo passwd -dl root
  sudo usermod -L root
  ```

## Troubleshooting

### Missing boot option

Try [re-installing the bootloader from installation media](https://nixos.wiki/wiki/Bootloader#Re-installing_the_bootloader).
Or move EFI files to generic locations for old BIOSes:
```bash
mv /boot/EFI/NixOS-boot /boot/EFI/boot
mv /boot/EFI/boot/grubx64.efi /boot/EFI/boot/bootx64.efi
```

### No display output after GRUB

Try adding `nomodeset` to the kernel parameters in GRUB.

## Tasks

### Switch

Requires: switch-nixos, switch-home-manager

Switch to the new nixos and home-manager configurations.

### Deploy

Deploy the nixos configurations to all machines with deploy-rs.

```bash
deploy -s
```

### Switch-NixOS

Switch to the new nixos configuration.

```bash
sudo nixos-rebuild switch --flake .# --accept-flake-config
```

### Switch-home-manager

Switch to the new home-manager configuration for the current user.

```bash
home-manager switch --flake ".#$USER@`hostname`" 
```

### Garbage-collect

Cleanup unused nix store paths, then print a summary.

```bash
nix-collect-garbage --quiet
```

### Garbage-collect-delete

Deletes all but the current generation of NixOS and cleanup leftovers, then print a summary.

```bash
sudo nix-collect-garbage -d --quiet
```
