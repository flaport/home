# System Initialization Roles

This document explains the new system initialization roles that automate post-installation configuration from the manual installation guide.

## Overview

Three new roles have been added to automate the system initialization steps from `.install/README.md`:

1. **locale** - Timezone and locale configuration
2. **hostname** - Hostname configuration
3. **user-config** - User and sudo configuration

All three roles are tagged with `init` for easy execution together.

**Note:** Bootloader configuration (rEFInd/GRUB) is intentionally NOT automated as it's too risky. Follow the manual installation guide for bootloader setup.

## Configuration

### Default Values

The roles use sensible defaults that can be customized:

```yaml
# In group_vars/all.yml
system_timezone: "Europe/Brussels"
system_locale: "en_US.UTF-8"
system_hostname: "archframe"
git_user_name: "Your Name"        # Optional
git_user_email: "your@email.com"  # Optional
# Note: Bootloader is NOT configured by Ansible - too risky
```

### Customizing Settings

**Option 1: Edit group_vars/all.yml**
```bash
vim ~/.ansible/group_vars/all.yml
# Change values as needed
```

**Option 2: Override with --extra-vars**
```bash
ansible-playbook site.yml --tags "init" \
  --extra-vars "system_hostname=mylaptop system_timezone=US/Pacific" \
  --ask-become-pass
```

## Role Details

### 1. Locale Role

**What it does:**
- Sets system timezone (default: Europe/Brussels)
- Configures hardware clock sync
- Enables specified locale in `/etc/locale.gen` (default: en_US.UTF-8)
- Generates locales
- Sets system-wide locale in `/etc/locale.conf`
- Enables NTP time synchronization

**Run standalone:**
```bash
ansible-playbook site.yml --tags "locale" --ask-become-pass
```

**Customize:**
```bash
ansible-playbook site.yml --tags "locale" \
  --extra-vars "system_timezone=US/Eastern system_locale=en_GB.UTF-8" \
  --ask-become-pass
```

### 2. Hostname Role

**What it does:**
- Sets system hostname (default: archframe)
- Updates `/etc/hostname`
- Configures `/etc/hosts` with proper localhost and hostname entries

**Run standalone:**
```bash
ansible-playbook site.yml --tags "hostname" --ask-become-pass
```

**Customize:**
```bash
ansible-playbook site.yml --tags "hostname" \
  --extra-vars "system_hostname=mydesktop" \
  --ask-become-pass
```

### 3. User Config Role

**What it does:**
- Ensures current user has sudo privileges via `/etc/sudoers.d/`
- Configures git user name and email (if variables are set)
- Creates standard user directories:
  - `~/.local/bin`
  - `~/.local/share`
  - `~/.config`
  - `~/.cache`
- Sets user shell to zsh (if zsh is installed)

**Run standalone:**
```bash
ansible-playbook site.yml --tags "user-config" --ask-become-pass
```

**Customize with git settings:**
```bash
ansible-playbook site.yml --tags "user-config" \
  --extra-vars "git_user_name='John Doe' git_user_email='john@example.com'" \
  --ask-become-pass
```

## Usage Examples

### Run All Initialization

```bash
# Run all three initialization roles
ansible-playbook site.yml --tags "init" --ask-become-pass

# Or use the Makefile
make init
```

### Skip Initialization

If your system is already configured and you only want to install packages:

```bash
# Skip all init roles
ansible-playbook site.yml --skip-tags "init" --ask-become-pass

# Or skip specific init roles
ansible-playbook site.yml --skip-tags "hostname,locale" --ask-become-pass
```

### Full Post-Installation Setup

After a fresh Arch installation following `.install/README.md`:

```bash
cd ~/.ansible

# 1. Install Ansible collections
make requirements

# 2. Preview what will be configured
make check

# 3. Run system initialization
make init

# 4. Install everything else
ansible-playbook site.yml --skip-tags "init" --ask-become-pass
```

### Custom Installation Order

```bash
# 1. Initialize system
make init

# 2. Install base tools
make base

# 3. Install terminal and desktop
ansible-playbook site.yml --tags "terminal,desktop" --ask-become-pass

# 4. Install development tools
make programming
```

## Integration with Manual Install

These roles automate steps from `.install/README.md`:

| Manual Step | Automated By | Line Ref |
|-------------|--------------|----------|
| Set timezone | locale role | Line 47 |
| Set hardware clock | locale role | Line 48 |
| Configure locale | locale role | Lines 52-55 |
| Set hostname | hostname role | Line 56 |
| Configure /etc/hosts | hostname role | Lines 57-60 |
| Install rEFInd (UEFI) | **Manual only** | Lines 73-83 |
| Install GRUB (BIOS) | **Manual only** | Lines 84-87 |
| Hide GRUB menu | **Manual only** | Lines 88-91 |
| Configure sudo | user-config role | Lines 95-97 |
| Configure git | user-config role | Lines 109-111 |

**Note:** Bootloader configuration is too risky to automate and must be done manually following `.install/README.md`.

## Safety Considerations

### When to Skip

Skip initialization roles if:
- ✅ System is already configured
- ✅ Running on an existing installation
- ✅ You prefer manual configuration
- ✅ Testing other roles only

### When to Use

Use initialization roles when:
- ✅ Fresh Arch Linux installation
- ✅ Following `.install/README.md` post-install
- ✅ Setting up new machine
- ✅ Standardizing configuration across machines

### Bootloader Configuration

**Bootloader setup is NOT automated** due to the high risk of making the system unbootable. You must configure the bootloader manually following `.install/README.md` (lines 64-91).

The playbook will NOT:
- Install rEFInd or GRUB
- Modify boot configuration
- Touch the boot partition

This must be done manually during initial system installation.

## Troubleshooting

### Locale Issues

**Problem:** Locale not generating
```bash
# Check if locale exists
locale -a

# Manually generate
sudo locale-gen

# Verify
echo $LANG
```

**Problem:** Wrong timezone
```bash
# Check current timezone
timedatectl

# List available timezones
timedatectl list-timezones

# Override in playbook
ansible-playbook site.yml --tags "locale" \
  --extra-vars "system_timezone=America/New_York" --ask-become-pass
```

### Hostname Issues

**Problem:** Hostname not persisting after reboot
```bash
# Check hostname
hostname
hostnamectl

# Verify files
cat /etc/hostname
cat /etc/hosts
```

### User Config Issues

**Problem:** User can't sudo
```bash
# Check sudoers file
sudo cat /etc/sudoers.d/$USER

# Check permissions
ls -la /etc/sudoers.d/$USER  # Should be 0440
```

## Advanced Configuration

### Multiple Hosts with Different Settings

Use host-specific variables:

```bash
# host_vars/laptop.yml
system_hostname: "mylaptop"
system_timezone: "US/Pacific"

# host_vars/desktop.yml
system_hostname: "mydesktop"
system_timezone: "US/Eastern"
```

### Test Mode

Test configuration without applying:

```bash
# Check what would change
ansible-playbook site.yml --tags "init" --check --diff --ask-become-pass

# With verbose output
ansible-playbook site.yml --tags "init" --check --diff -vv --ask-become-pass
```

## See Also

- [README.md](README.md) - Complete documentation
- [QUICKSTART.md](QUICKSTART.md) - Quick start guide
- [TROUBLESHOOTING.md](TROUBLESHOOTING.md) - Problem solving
- [.install/README.md](../.install/README.md) - Original manual installation guide
- [group_vars/all.yml](group_vars/all.yml) - Configuration variables
