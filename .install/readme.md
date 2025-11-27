# Clean Arch Linux Installation.

**_Note:_** These installation instructions were last checked and updated on 2025-01-27.

## Table of Contents

1. [Dual Boot with Windows (Preparation)](#dual-boot-with-windows-preparation)
2. [First Installation with bootable USB](#first-installation-with-bootable-usb)
3. [Post Installation](#post-installation)

---

## Dual Boot with Windows (Preparation)

If you plan to dual-boot Arch Linux with Windows, follow these preparation steps **before** installing Arch Linux.

### ⚠️ Prerequisites and Warnings

**IMPORTANT - Do this BEFORE starting Arch installation:**

1. **Disable Secure Boot**
   - Secure Boot must be disabled as Arch Linux installation media does not support it
   - Boot into UEFI/BIOS settings (usually F2, F10, F12, or Del during boot)
   - Navigate to Security or Boot settings
   - Disable Secure Boot
   - Save and exit
   - **Note:** You can re-enable Secure Boot after installation if you configure it properly

2. **Disable Windows BitLocker (Drive Encryption)**
   - If Windows drive is encrypted with BitLocker, you MUST decrypt it first
   - In Windows: Settings → System → Storage → Advanced storage settings → BitLocker
   - Turn off BitLocker and wait for full decryption to complete (can take hours)
   - **Warning:** Resizing an encrypted partition can cause data loss!

3. **Disable Fast Startup in Windows**
   - Fast Startup can cause filesystem corruption in dual-boot setups
   - In Windows: Control Panel → Power Options → Choose what the power buttons do
   - Click "Change settings that are currently unavailable"
   - Uncheck "Turn on fast startup (recommended)"
   - Save changes

4. **Backup Important Data**
   - Always backup your Windows data before partitioning
   - Create a Windows recovery USB in case something goes wrong

### Shrinking Windows Partition

You need to make space for Linux by shrinking the Windows partition.

**Method 1: From Windows (Recommended)**

1. **Boot into Windows**

2. **Open Disk Management**
   - Press `Win + X` and select "Disk Management"
   - Or search for "Create and format hard disk partitions"

3. **Shrink the Windows partition**
   - Right-click on the C: drive (usually the largest partition)
   - Select "Shrink Volume"
   - In "Enter the amount of space to shrink in MB", calculate:
     - For a 1TB drive leaving 500GB for Windows: Enter `512000` MB (500GB)
     - This will free up ~500GB for Linux
   - Click "Shrink"
   - You should now see unallocated space (don't format it!)

4. **Reboot** and proceed with Arch installation

**Method 2: From Arch Live USB (Advanced)**

If you need to shrink from the Arch installation environment:

1. **Boot from Arch USB**

2. **Install ntfs-3g and parted**
   ```bash
   pacman -Sy ntfs-3g parted
   ```

3. **Check partition layout**
   ```bash
   lsblk
   fdisk -l
   ```

4. **Shrink NTFS partition**
   ```bash
   # Find your Windows partition (usually /dev/nvme0n1p3 or /dev/sda3)
   ntfsresize --info /dev/nvme0n1p3  # Check current size and min size

   # Shrink to desired size (e.g., 500GB = 500G)
   ntfsresize --size 500G /dev/nvme0n1p3

   # Resize the partition table to match
   parted /dev/nvme0n1
   (parted) print  # Note partition number
   (parted) resizepart 3 500GB  # Adjust partition 3 to 500GB
   (parted) quit
   ```

### Understanding the Boot Partition (EFI System Partition)

When dual-booting with Windows on a UEFI system:

**What you need to know:**
- Windows creates an EFI System Partition (ESP) during installation, typically 100-500MB
- This ESP already contains Windows bootloader files in `/EFI/Microsoft/`
- Linux will **share this same ESP** - you don't create a new one!
- rEFInd (or GRUB) will be installed alongside Windows bootloader in `/EFI/refind/` or `/EFI/GRUB/`

**Check if ESP is large enough:**
```bash
# From Arch USB, after mounting Windows ESP (usually /dev/nvme0n1p1 or /dev/sda1)
df -h /boot/efi
```

**ESP Size Requirements:**
- Windows typically creates 100MB (older) or 260MB+ (newer installations)
- Minimum for dual boot: 200MB
- Recommended: 512MB or more
- rEFInd needs: ~20-30MB
- GRUB needs: ~10-20MB

**If ESP is too small (<200MB):**
- You may need to expand it (complex, requires backup)
- Or use GRUB instead of rEFInd (smaller footprint)
- Consider consulting: https://wiki.archlinux.org/title/EFI_system_partition#Insufficient_space

**What will be on the shared ESP:**
```
/boot/efi/
├── EFI/
│   ├── Boot/          # Fallback bootloader
│   ├── Microsoft/     # Windows bootloader (DON'T TOUCH!)
│   └── refind/        # rEFInd bootloader (or GRUB/)
└── ...
```

### Partitioning for Dual Boot

When you reach the partitioning step in the main installation:

**For UEFI dual boot, you will have:**
1. **ESP (EFI System Partition)** - Already exists from Windows (typically 100-500MB)
   - **DO NOT format or delete this!**
   - Typically `/dev/nvme0n1p1` or `/dev/sda1`
   - Mount this at `/mnt/boot/efi`

2. **Windows partition** - Your shrunk Windows C: drive
   - Leave this alone!

3. **Swap partition (optional)** - Create in free space (size of RAM)
   - Example: `/dev/nvme0n1p5` or `/dev/sda5`

4. **Linux root partition** - Create in free space (50GB minimum)
   - Example: `/dev/nvme0n1p6` or `/dev/sda6`

5. **Linux home partition** - Create in remaining free space
   - Example: `/dev/nvme0n1p7` or `/dev/sda7`

**Modified partitioning commands in the main guide:**
- When you see "Create a first partition of 250M for boot" → **SKIP THIS** (use existing ESP)
- When you see "Format the boot partition" → **SKIP THE FORMAT** (just mount it)
- When you see "Mount boot partition" → Mount the **existing Windows ESP**

### Boot Priority After Installation

After installing Arch and rEFInd/GRUB:

**rEFInd (Recommended for dual boot):**
- rEFInd will automatically detect both Linux and Windows
- Shows a graphical boot menu with both options
- No manual configuration needed for Windows detection

**GRUB:**
- GRUB can detect Windows with `os-prober`
- Install: `pacman -S os-prober`
- Enable in `/etc/default/grub`: `GRUB_DISABLE_OS_PROBER=false`
- Regenerate config: `grub-mkconfig -o /boot/grub/grub.cfg`

**Setting default boot order in UEFI:**
```bash
# After installation, check boot order
efibootmgr -v

# Set default (e.g., rEFInd first, Windows second)
efibootmgr -o 0003,0001  # Replace with your boot numbers
```

---

## First Installation with bootable USB

- Download **the most recent** Arch Linux ISO [http://archlinux.org/download](http://archlinux.org/download) from a mirror **near you**, and create a USB flash drive.
- Start the computer using the USB drive. When greeted with a boot menu, choose the (first) "boot archlinux" option. After booting you should be logged into a tty shell.
- Now, connect to the internet. A **wired** internet connection is definitely recommended. However, if this is not an option try using `iwctl`.
- Check your internet connection: `ping google.com`. Sometimes if you are on a work or university network, `ping`-ing a domain might not work. If that's the case, try `curl`. For example: `curl https://ipinfo.io/ip` to get your public ip address. If you are sure you are connected to the internet, you can proceed.
- Set the clock right: `timedatectl set-ntp true`
- Check the boot mode: `ls /sys/firmware/efi/efivars`. If the directory is empty or does not exist, you are in traditional **BIOS** boot-mode, else you are in **UEFI** boot-mode. In the following, sections that are prepended with “**BIOS**” or “**UEFI**” should only be performed if you are in that specific boot-mode.
- Check which block device name belongs to your hard drive with `lsblk`. Here, we assume `/dev/sdx` is the disk to be partitioned.

### Partitioning

**⚠️ For dual-boot with Windows:** If you followed the [dual-boot preparation](#dual-boot-with-windows-preparation), you should already have free space and an existing Windows ESP. In this case:
- **DO NOT delete the ESP (EFI System Partition)** - typically the first small partition (~100-500MB, type `EFI System`)
- **DO NOT delete or modify Windows partitions**
- Only create Linux partitions in the **free/unallocated space**
- Skip to "Create partitions in free space" below

**For fresh installation (no dual-boot):**

- **[skip this step if you are reinstalling arch on an already correctly partitioned drive]** Check the block device name with `lsblk` (here we assume to work on `/dev/sdx`) and create hard disk partitions with `cfdisk`: `cfdisk /dev/sdx`. If asked, select `gpt` partition table. Then
  - If the harddrive you want to install arch linux on is not empty, delete all partitions
  - Create a first partition of `250M`. This will be used for the boot partition
  - Create a second partition of `XG`. This will be the swap partition (make `X` as big as the total amount of ram in your system).
  - Create a third partition of at least `30G` (I recommend `50G` to be more comfortable). This will be the root partition.
  - Create a fourth partition containing the rest of the disk space. This will be the home partition.
  - Finally, write the partition table to the hard drive and quit.
  - Reboot to ensure the partition tables are updated correctly

**For dual-boot (create partitions in free space):**

- Use `cfdisk /dev/sdx` to create partitions **only in the free space** left by Windows
- Existing partitions will show up - **leave them alone!**
- Navigate to the `Free space` entry and create:
  - **Swap partition**: Size of RAM (e.g., 16G)
  - **Root partition**: At least 50G
  - **Home partition**: Remaining free space
- Write the partition table and quit
- **Example layout after partitioning for dual-boot:**
  ```
  /dev/nvme0n1p1  500M   EFI System (Windows ESP - existing, don't touch)
  /dev/nvme0n1p2  16M    Microsoft reserved (Windows - don't touch)
  /dev/nvme0n1p3  450G   Microsoft basic data (Windows C: - don't touch)
  /dev/nvme0n1p4  650M   Windows recovery (don't touch)
  /dev/nvme0n1p5  16G    Linux swap (NEW - you created this)
  /dev/nvme0n1p6  50G    Linux root (NEW - you created this)
  /dev/nvme0n1p7  434G   Linux home (NEW - you created this)
  ```
### Formatting Partitions

**⚠️ For dual-boot:** Adjust partition numbers based on your actual layout (see `lsblk`). Windows partitions will have lower numbers.

- Format the partitions in the required format
  - Format the boot partition:
    - **UEFI (fresh install)**: `mkfs.fat -F32 /dev/sdx1`
    - **UEFI (dual-boot)**: **DO NOT FORMAT** - Windows ESP is already formatted!
    - **BIOS**: `mkfs.ext4 /dev/sdx1`
  - Format and enable the swap partition:
    - **Fresh install**: `mkswap /dev/sdx2` and `swapon /dev/sdx2`
    - **Dual-boot example**: `mkswap /dev/nvme0n1p5` and `swapon /dev/nvme0n1p5`
  - Format the root partition as `ext4`:
    - **Fresh install**: `mkfs.ext4 /dev/sdx3`
    - **Dual-boot example**: `mkfs.ext4 /dev/nvme0n1p6`
  - **[skip this step if you are reinstalling arch and want to keep your home folder]** Format the home partition as `ext4`:
    - **Fresh install**: `mkfs.ext4 /dev/sdx4`
    - **Dual-boot example**: `mkfs.ext4 /dev/nvme0n1p7`
### Mounting Partitions

**⚠️ For dual-boot:** Use the correct partition numbers from your layout!

- Mount the newly created partitions:
  - Mount root partition:
    - **Fresh install**: `mount /dev/sdx3 /mnt`
    - **Dual-boot example**: `mount /dev/nvme0n1p6 /mnt`
  - Mount home partition:
    - `mkdir /mnt/home`
    - **Fresh install**: `mount /dev/sdx4 /mnt/home`
    - **Dual-boot example**: `mount /dev/nvme0n1p7 /mnt/home`
  - **UEFI**: Mount boot partition (Windows ESP for dual-boot):
    - `mkdir -p /mnt/boot/efi`
    - **Fresh install**: `mount /dev/sdx1 /mnt/boot/efi`
    - **Dual-boot example**: `mount /dev/nvme0n1p1 /mnt/boot/efi` (mount the existing Windows ESP!)
  - **BIOS**: Mount boot partition:
    - `mkdir /mnt/boot`
    - `mount /dev/sdx1 /mnt/boot`
    - Set the bootable flag on `/dev/sdx1`: `cfdisk` -> `[ Type ]` -> `BIOS boot` -> `[ Write ]`
- **[optional]** Edit the pacman mirrorlist at `/etc/pacman.d/mirrorlist` with `vim` or `nano`. Move a few geographically close mirrors higher on the list.
- Now, install archlinux with the magical `pacstrap` command: `pacstrap -K /mnt base base-devel linux linux-firmware`. The `-K` flag initializes a fresh pacman keyring for the new installation.
- **Note:** The installation will later include CPU microcode updates (`intel-ucode` or `amd-ucode`) for optimal security and stability.
- Create your filesystem tab `fstab`, which is needed to mount each of the partitions correctly when booting into your freshly installed archlinux machine: `genfstab -U /mnt > /mnt/etc/fstab`
- Now another magical arch linux installation command: change root: `arch-chroot /mnt`. You're now logged in as root in the newly create arch-linux machine.
- List all timezones: `ls /usr/share/zoneinfo/**/**` and link the one that corresponds best to your timezone to `/etc/localtime`. For example: `ln -sf /usr/share/zoneinfo/Europe/Brussels /etc/localtime`
- Set the hardware clock: `hwclock --systohc`
- Install a terminal editor such as `nano`, `vim` or `neovim`:
  - `sudo pacman -S vim`
  - export EDITOR=vim
- Set the locale:
  - edit `/etc/locale.gen` with one of the editors and uncomment the locale needed (e.g. `en_US.UTF-8 UTF-8`). You can probably choose between a `UTF-8` and `ISO` option. You probably want `UTF-8`.
  - Generate the locales: `locale-gen`
  - Set your language `echo "LANG=en_US.UTF-8" > /etc/locale.conf`
- Set your hostname `echo "<hostname>" > /etc/hostname`
- Add matching entries by editing `/etc/hosts`:
  - `127.0.0.1 localhost`
  - `::1 localhost`
  - `127.0.1.1 <hostname>.localdomain <hostname>`
- Install and enable networkmanager
  - `pacman -S networkmanager`
  - `systemctl enable NetworkManager`
- **UEFI**: Install a bootloader
  - `pacman -S grub efibootmgr # always re-install, even when already installed.`
  - `grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi`
  - Generate config file for bootloader: `grub-mkconfig -o /boot/grub/grub.cfg`
  - Copy the generated config to a new folder:
    - `mkdir /boot/efi/EFI/BOOT`
    - `cp /boot/efi/EFI/GRUB/grubx64.efi /boot/efi/EFI/BOOT/BOOTX64.EFI`
  - Create a startup file:
    - `echo 'bcf boot add 1 fs0:\EFI\GRUB\grubx64.efi "GRUB"' > /boot/efi/startup.nsh`
- **UEFI**: Extra: rEFInd Bootloader. When working with EFI file systems, one can choose to
  install the rEFInd bootloader, which is a bit more slick than GRUB:
  - intel:
    - `pacman -S intel-ucode linux linux-firmware refind # always re-install, even when already installed.`
  - amd:
    - `pacman -S amd-ucode linux linux-firmware refind # always re-install, even when already installed.`
  - Install rEFInd: `refind-install`
  - ⚠️ **IMPORTANT:** `refind-install` in chroot populates `/boot/refind_linux.conf` with kernel options from the live system, NOT your installed system. You MUST edit this file to ensure the kernel parameters (especially `root=UUID=...`) match your actual system, or you will get a kernel panic on boot.
  - To find your root partition UUID, run: `blkid /dev/sdx3` (replace sdx3 with your root partition)
  - Edit `/boot/refind_linux.conf` such that only the following line remains:
  - `"Boot with standard options" "rw root=UUID=<your-root-partition-uuid>"`
  - Replace `<your-root-partition-uuid>` with the actual UUID from the `blkid` command
  - (optional) download and install a theme for your rEFInd splash screen. For example
  this one: https://github.com/EvanPurkhiser/rEFInd-minimal.
- **BIOS** Install a bootloader
  - `pacman -S grub`
  - `grub-install --target=i386-pc /dev/sdx`
  - Generate config file for bootloader: `grub-mkconfig -o /boot/grub/grub.cfg`
- **[optional]**: hide GRUB during boot (useful for single OS installations):
  - Edit `/etc/default/grub` and set:
    - `GRUB_TIMEOUT=0`
  - Regenerate the grub config: `sudo grub-mkconfig -o /boot/grub/grub.cfg`
- Create a root password: `passwd`
- Create new user: `useradd -m flaport`. The `-m` flag makes sure a home directory is created. If you are _reinstalling_ the root partition, you should leave this out.
- Create a password for the new user: `passwd flaport`
- Add `flaport` to the sudoers (change the editor to your preferred one):
  - edit the sudoers file `EDITOR=vim && visudo`
  - under the 'User privilege specification' section, add the line `flaport ALL=(ALL) ALL`
- Exit `chroot` session: `exit`
- Unmount all partitions: `umount -R /mnt`
- Shutdown the computer: `shutdown now`
- Remove the USB Drive, boot up the computer and log into the newly setup user account.

## Post Installation

After completing the manual installation steps above, you have two options for setting up your system:

### Option 1: Automated Setup with Ansible (Recommended)

The repository now includes a comprehensive Ansible setup that automates all post-installation configuration.

1. **Reboot and login** as the newly created user

2. **Install git and Ansible:**
   ```bash
   sudo pacman -S git ansible
   ```

3. **Clone this repository:**
   ```bash
   cd ~
   git clone <repository-url>
   cd home
   ```

4. **Configure git (will also be done by Ansible):**
   ```bash
   git config --global user.name <username>
   git config --global user.email <email>
   ```

5. **Update git submodules:**
   ```bash
   git submodule update --init --recursive
   ```

6. **Install Ansible collections:**
   ```bash
   cd .ansible
   make requirements
   ```

7. **Review and customize settings** (optional):
   ```bash
   # Edit system settings if you want different defaults
   vim .ansible/group_vars/all.yml
   # Default values:
   # - Timezone: Europe/Brussels
   # - Locale: en_US.UTF-8
   # - Hostname: archframe
   ```

8. **Preview what will be installed** (dry-run):
   ```bash
   make check
   ```

9. **Run the full installation:**
   ```bash
   make install
   # This will:
   # - Configure locale and timezone
   # - Set hostname
   # - Configure user and sudo
   # - Install all packages (yay, terminal tools, desktop environment, etc.)
   # - Build custom software (dwm, st, dmenu, scroll)
   # - Configure all services
   ```

10. **Reboot the computer:**
    ```bash
    sudo reboot
    ```

**Documentation:**
- Quick start guide: `.ansible/QUICKSTART.md`
- Complete documentation: `.ansible/README.md`
- System initialization: `.ansible/INIT_ROLES.md`
- All documentation index: `.ansible/INDEX.md`

**Selective Installation:**
```bash
# Install only specific components
make base           # Base system only
make terminal       # Terminal tools only
make desktop        # Desktop environment
make programming    # Development tools

# Or use tags
ansible-playbook site.yml --tags "base,terminal,desktop" --ask-become-pass

# Skip system initialization if already configured
ansible-playbook site.yml --skip-tags "init" --ask-become-pass
```

### Option 2: Manual Setup (Legacy)

If you prefer manual installation or want to customize everything yourself:

1. **Reboot and login** as the newly created user

2. **Install git:**
   ```bash
   sudo pacman -S git
   git config --global user.name <username>
   git config --global user.email <email>
   ```

3. **Follow the arch-home installation instructions** laid out in [the main readme](../.github/readme.md#installation-instructions) of this repository.

4. **Reboot the computer one last time.**

---

**Note:** The Ansible setup (Option 1) is recommended as it:
- ✅ Automates 100% of the post-installation process
- ✅ Is idempotent (safe to run multiple times)
- ✅ Provides dry-run capability to preview changes
- ✅ Allows selective installation with tags
- ✅ Includes comprehensive documentation
- ✅ Can be easily customized via variables
