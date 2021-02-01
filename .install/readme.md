# Clean Arch Linux Installation.

***Note:*** These installation instructions were last checked by me on 2020.11.07.

## First Installation with bootable USB
* Download **the most recent** Arch Linux ISO [http://archlinux.org/download](http://archlinux.org/download) from a mirror **near you**, and create a USB flash drive.
* Start the computer using the USB drive. When greeted with a boot menu, choose the (first) "boot archlinux" option. After booting you should be logged into a tty shell.
* Now, connect to the internet. A **wired** internet connection is definitely recommended. However, if this is not an option try using `iwctl`.
* Check your internet connection: `ping google.com`. Sometimes if you are on a work or university network, `ping`-ing a domain might not work. If that's the case, try `curl`. For example: `curl https://ipinfo.io/ip` to get your public ip address. If you are sure you are connected to the internet, you can proceed.
* Set the clock right: `timedatectl set-ntp true`
* Check the boot mode: `ls /sys/firmware/efi/efivars`. If the directory is empty or does not exist, you are in traditional **BIOS** boot-mode, else you are in **UEFI** boot-mode. In the following, sections that are prepended with “**BIOS**” or “**UEFI**” should only be performed if you are in that specific boot-mode.
* Check which block device name belongs to your hard drive with `lsblk`. Here, we assume `/dev/sdx` is the disk to be partitioned.
* **[skip this step if you are reinstalling arch on an already correctly partitioned drive]** Check the block device name with `lsblk` (here we assume to work on `/dev/sdx`) and create hard disk partitions with `cfdisk`: `cfdisk /dev/sdx`. If asked, select `gpt` partition table. Then
    * If the harddrive you want to install arch linux on is not emtpy, delete all partitions
    * Create a first partition of `250M`. This will be used for the boot partition
    * Create a second partition of `XG`. This will be the swap partition (make `X` as big as the total amount of ram in your system).
    * Create a third partition of at least `30G` (I recommend `50G` to be more comfortable). This will be the root partition.
    * Create a fourth partition containing the rest of the disk space. This will be the home partition.
    * Finally, write the partition table to the hard drive and quit.
    * Reboot to ensure the partition tables are updated correctly
* Format the partitions in the required format
    * Format the boot partition:
        * **UEFI**: `mkfs.fat -F32 /dev/sdx1`
        * **BIOS**: `mkfs.ext4 /dev/sdx1`
    * Format and enable the swap partition:
        * `mkswap /dev/sdx2`
        * `swapon /dev/sdx2`
    * Format the root partition as `ext4`: `mkfs.ext4 /dev/sdx3`
    * **[skip this step if you are reinstalling arch and want to keep your home folder]** Format the home partition as `ext4`: `mkfs.ext4 /dev/sdx4`.
* Mount the newly created partitions:
    * Mount root partition: `mount /dev/sdx3 /mnt`
    * Mount home partition:
        * `mkdir /mnt/home`
        * `mount /dev/sdx4 /mnt/home`
    * **UEFI**: Mount boot partition:
        * `mkdir -p /mnt/boot/efi`
        * `mount /dev/sdx1 /mnt/boot/efi`
    * **BIOS**: Mount boot partition:
        * `mkdir /mnt/boot`
        * `mount /dev/sdx1 /mnt/boot`
        * Set the bootable flag on `/dev/sdx1`: `cfdisk` -> `[ Type ]` -> `BIOS boot` -> `[ Write ]`
* **[optional]** Edit the pacman mirrorlist at `/etc/pacman.d/mirrorlist` with `vim` or `nano`. Move a few geographically close mirrors higher on the list.
* Now, install archlinux with the magical `pacstrap` command: `pacstrap -i /mnt base base-devel linux linux-firmware`. When prompted choose all the default answers.
* Create your filesystem tab `fstab`, which is needed to mount each of the partitions correctly when booting into your freshly installed archlinux machine: `genfstab -U /mnt > /mnt/etc/fstab`
* Now another magical arch linux installation command: change root: `arch-chroot /mnt`. You're now logged in as root in the newly create arch-linux machine.
* List all timezones: `ls /usr/share/zoneinfo/**/**` and link the one that corresponds best to your timezone to `/etc/localtime`. For example: `ln -sf /usr/share/zoneinfo/Europe/Brussels /etc/localtime`
* Set the hardware clock: `hwclock --systohc`
* Install a terminal editor such as `nano`, `vim` or `neovim`:
    * `sudo pacman -S vim`
    * export EDITOR=vim
* Set the locale:
    * edit `/etc/locale.gen` with one of the editors and uncomment the locale needed (e.g. `en_US.UTF-8 UTF-8`). You can probably choose between a `UTF-8` and `ISO` option. You probably want `UTF-8`.
    * Generate the locales: `locale-gen`
    * Set your language `echo "LANG=en_US.UTF-8"  > /etc/locale.conf`
* Set your hostname `echo "<hostname>" > /etc/hostname`
* Add matching entries by editing `/etc/hosts`:
    * `127.0.0.1    localhost`
    * `::1          localhost`
    * `127.0.1.1    <hostname>.localdomain <hostname>`
* Install and enable networkmanager
    * `pacman -S networkmanager`
    * `systemctl enable NetworkManager`
* **UEFI**: Install a bootloader
    * `pacman -S grub efibootmgr`
    * `grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi`
    * Generate config file for bootloader: `grub-mkconfig -o /boot/grub/grub.cfg`
    * Copy the generated config to a new folder:
        * `mkdir /boot/efi/EFI/BOOT`
        * `cp /boot/efi/EFI/GRUB/grubx64.efi /boot/efi/EFI/BOOT/BOOTX64.EFI`
    * Create a startup file:
        * `echo 'bcf boot add 1 fs0:\EFI\GRUB\grubx64.efi "GRUB"' > /boot/efi/startup.nsh`
* **UEFI**: Extra: rEFInd Bootloader. When working with EFI file systems, one can choose to
install the rEFInd bootloader, which is a bit more slick than GRUB:
    * `pacman -S intel-ucode linux linux-firmware` OR `pacman -S amd-ucode linux linux-firmware`
    * `pacman -S refind-efi`
    * Install rEFInd: `refind-install`
    * Edit `/boot/refind_linux.conf` such that only the following line remains:
        * `"Boot with standard options" "rw root=UUID=<your-root-partition-uuid>"`
    * (optional) download and install a theme for your rEFInd splash screen. For example
    this one: https://github.com/EvanPurkhiser/rEFInd-minimal.
* **BIOS** Install a bootloader
    * `pacman -S grub`
    * `grub-install --target=i386-pc /dev/sdx`
    * Generate config file for bootloader: `grub-mkconfig -o /boot/grub/grub.cfg`
* **[optional]**: hide GRUB during boot (useful for single OS installations):
    * Edit `/etc/default/grub` and set:
        * `GRUB_TIMEOUT=0`
    * Regenerate the grub config: `sudo grub-mkconfig -o /boot/grub/grub.cfg`
* Create a root password: `passwd`
* Create new user: `useradd -m flaport`. The `-m` flag makes sure a home directory is created. If you are *reinstalling* the root partition, you should leave this out.
* Create a password for the new user: `passwd flaport`
* Add `flaport` to the sudoers (change the editor to your preferred one):
    * edit the sudoers file `EDITOR=vim && visudo`
    * under the 'User privilege specification' section, add the line `flaport ALL=(ALL) ALL`
* Exit `chroot` session: `exit`
* Unmount all partitions: `umount -R /mnt`
* Shutdown the computer: `shutdown now`
* Remove the USB Drive, boot up the computer and log into the newly setup user account.

## Post Installation
* Reboot and login as the newly created user
* Install git:
```
    sudo pacman -S git
    git config --global user.name <username>
    git config --global user.email <email>
```
* Follow the arch-home installation instructions laid out in [the main readme](../.github/readme.md#installation-instructions) of this repository.
* Reboot the computer one last time.
