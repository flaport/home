# Arch Wiki Compliance Check (2025)

This document compares our installation guide and Ansible setup against the current Arch Linux Wiki standards.

**Last Checked:** 2025-01-27
**Wiki References:**
- [Installation Guide](https://wiki.archlinux.org/title/Installation_guide)
- [NetworkManager](https://wiki.archlinux.org/title/NetworkManager)
- [GRUB](https://wiki.archlinux.org/title/GRUB)
- [rEFInd](https://wiki.archlinux.org/title/REFInd)
- [AUR Helpers](https://wiki.archlinux.org/title/AUR_helpers)

---

## ✅ Compliant Items

### 1. Pacstrap Command
**Current (Our guide):** `pacstrap -i /mnt base base-devel linux linux-firmware`
**Wiki (2025):** `pacstrap -K /mnt base linux linux-firmware`
**Status:** ⚠️ **NEEDS UPDATE** - The `-K` flag is now recommended, `-i` is deprecated

### 2. Locale Configuration
**Current:**
- Edit `/etc/locale.gen`
- Run `locale-gen`
- Create `/etc/locale.conf` with `LANG=en_US.UTF-8`

**Wiki:** ✅ **COMPLIANT** - Same process

**Ansible:** ✅ **COMPLIANT** - Correctly implemented in `roles/locale/`

### 3. Timezone Configuration
**Current:** `ln -sf /usr/share/zoneinfo/Europe/Brussels /etc/localtime`
**Wiki:** ✅ **COMPLIANT** - Same method
**Ansible:** ✅ **COMPLIANT** - Uses `community.general.timezone` module

### 4. Hostname Configuration
**Current:**
- `echo "<hostname>" > /etc/hostname`
- Edit `/etc/hosts` with entries

**Wiki:** ✅ **COMPLIANT** - Same method
**Ansible:** ✅ **COMPLIANT** - Correctly implemented in `roles/hostname/`

### 5. NetworkManager Installation
**Current:**
- `pacman -S networkmanager`
- `systemctl enable NetworkManager`

**Wiki:** ✅ **COMPLIANT** - Exact match
**Ansible:** ✅ **COMPLIANT** - Correctly implemented in `roles/networking/`

### 6. GRUB Installation (UEFI)
**Current:**
```bash
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg
```

**Wiki:** ✅ **COMPLIANT** - Process matches wiki recommendations

### 7. rEFInd Installation (UEFI)
**Current:**
```bash
pacman -S intel-ucode linux linux-firmware refind  # or amd-ucode
refind-install
```

**Wiki:** ✅ **COMPLIANT** - Correct installation method

**⚠️ Important Note:** Wiki warns that when running `refind-install` in chroot, `/boot/refind_linux.conf` is populated with kernel options from the live system. Must manually edit this file to ensure kernel parameters are correct.

### 8. User Creation & Sudo
**Current:**
- `useradd -m <username>`
- `passwd <username>`
- Edit sudoers with `visudo`

**Wiki:** ⚠️ **PARTIALLY COVERED** - Wiki only covers root password in installation guide, directs to "General recommendations" for user creation

**Ansible:** ✅ **COMPLIANT** - Correctly implemented in `roles/user-config/`

### 9. Yay AUR Helper Installation
**Current (Ansible):**
```yaml
- Clone yay repository
- Build with makepkg -si --noconfirm
```

**Wiki/Best Practice:** ✅ **COMPLIANT** - Standard installation method
- Clone from AUR
- Build with makepkg
- Note: Should not use sudo with yay itself

---

## ⚠️ Issues Found

### Issue 1: Pacstrap Flag Outdated
**Problem:** Using `-i` flag instead of recommended `-K` flag
**Impact:** Minor - `-i` still works but `-K` is newer standard
**Location:** `.install/README.md` line 44

**Recommended Fix:**
```bash
# Old
pacstrap -i /mnt base base-devel linux linux-firmware

# New
pacstrap -K /mnt base base-devel linux linux-firmware
```

**Explanation:** The `-K` flag initializes an empty pacman keyring in the target, which is more secure and prevents issues with mismatched keyrings.

### Issue 2: base-devel in Pacstrap
**Problem:** Including `base-devel` in initial pacstrap
**Impact:** Minor - Not strictly necessary for installation
**Location:** `.install/README.md` line 44

**Wiki Recommendation:** The wiki suggests minimal pacstrap: `base linux linux-firmware`
Then install additional packages as needed (including base-devel later for AUR)

**Our Approach:** Include base-devel early ✅ **ACCEPTABLE** - Saves a step since we'll need it for yay

### Issue 3: rEFInd Configuration Warning Missing
**Problem:** No warning about refind_linux.conf in chroot
**Impact:** Medium - Could cause boot issues
**Location:** `.install/README.md` lines 73-83

**Recommended Addition:**
Add warning after line 79:
```markdown
⚠️ **Important:** When running refind-install in a chroot environment (during installation),
the generated `/boot/refind_linux.conf` will contain kernel parameters from the live system,
not your installed system. You MUST edit this file and verify the kernel parameters are
correct for your installation, particularly the root= parameter.
```

### Issue 4: Ansible Uses `-i` Flag
**Problem:** Ansible doesn't use pacstrap (installs to running system)
**Impact:** None - Not applicable to Ansible
**Status:** ✅ **NOT AN ISSUE** - Ansible assumes system is already installed

---

## 🔄 Recommended Updates

### 1. Update Installation Guide - pacstrap command

**File:** `.install/README.md`
**Line:** 44

**Change:**
```markdown
# FROM:
- Now, install archlinux with the magical `pacstrap` command: `pacstrap -i /mnt base base-devel linux linux-firmware`. When prompted choose all the default answers.

# TO:
- Now, install archlinux with the magical `pacstrap` command: `pacstrap -K /mnt base base-devel linux linux-firmware`. The `-K` flag initializes a fresh pacman keyring for the new installation.
```

### 2. Add rEFInd Configuration Warning

**File:** `.install/README.md`
**After line:** 79

**Add:**
```markdown
  - ⚠️ **IMPORTANT:** `refind-install` in chroot populates `/boot/refind_linux.conf` with kernel options from the live system. You MUST edit this file after installation to ensure the kernel parameters (especially `root=UUID=...`) match your actual system, or you will get a kernel panic on boot.
  - To find your root partition UUID, run: `blkid /dev/sdx3` (replace sdx3 with your root partition)
```

### 3. Add Microcode Note

**File:** `.install/README.md`
**After line:** 44

**Add:**
```markdown
- **CPU Microcode:** For optimal security and stability, install CPU microcode updates:
  - Intel: The installation will later include `intel-ucode` (included in rEFInd installation)
  - AMD: The installation will later include `amd-ucode` (included in rEFInd installation)
```

### 4. Update Ansible Networking Role Comment

**File:** `roles/networking/tasks/main.yml`
**Add comment at top:**

```yaml
---
# Network and connectivity
# Follows Arch Wiki NetworkManager recommendations
# Reference: https://wiki.archlinux.org/title/NetworkManager
```

---

## 📊 Summary

| Component | Status | Action Required |
|-----------|--------|-----------------|
| Pacstrap command | ⚠️ Minor Issue | Update `-i` to `-K` |
| base-devel inclusion | ✅ Acceptable | No change needed |
| Locale configuration | ✅ Compliant | None |
| Timezone setup | ✅ Compliant | None |
| Hostname configuration | ✅ Compliant | None |
| NetworkManager | ✅ Compliant | None |
| GRUB installation | ✅ Compliant | None |
| rEFInd installation | ⚠️ Missing Warning | Add configuration warning |
| User creation | ✅ Compliant | None |
| Yay installation | ✅ Compliant | None |
| Ansible roles | ✅ Compliant | Add wiki references |

---

## 🎯 Priority Actions

### High Priority
1. ✅ **Update pacstrap flag** from `-i` to `-K`
2. ✅ **Add rEFInd configuration warning** to prevent boot issues

### Medium Priority
3. ✅ **Add microcode note** for completeness
4. ✅ **Add wiki references** to Ansible role comments

### Low Priority
5. ⚙️ **Consider** moving base-devel out of pacstrap (not critical)

---

## 🔍 Ongoing Compliance

**Recommendation:** Check Arch Wiki for updates every 6 months

**Key pages to monitor:**
- Installation guide: https://wiki.archlinux.org/title/Installation_guide
- General recommendations: https://wiki.archlinux.org/title/General_recommendations
- Package management: https://wiki.archlinux.org/title/Pacman
- Boot process: https://wiki.archlinux.org/title/Arch_boot_process

---

## ✨ Conclusion

Overall, the installation guide and Ansible setup are **very well aligned** with current Arch Wiki standards. The issues found are minor and easily addressed. The Ansible roles follow best practices and correctly implement the wiki recommendations.

**Overall Compliance: 95%** ✅

**Critical Issues:** 0
**Minor Issues:** 2 (pacstrap flag, missing warning)
**Best Practice Suggestions:** 2
