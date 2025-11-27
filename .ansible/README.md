# Arch Linux Ansible Setup

This is an Ansible-based system configuration for Arch Linux, converted from the original bash script at `.install/arch_install`.

## Features

- **Idempotent**: Safe to run multiple times
- **Modular**: Organized into roles for easy customization
- **Tagged**: Run only specific parts of the setup
- **Well-documented**: Clear structure and comments

## Prerequisites

1. **Arch Linux** system (fresh or existing)
2. **Ansible** and **AUR helper support**:

```bash
sudo pacman -S ansible
yay -S ansible-aur-git  # or install kewlfft.aur collection manually
```

3. **AUR collection** (for AUR package support):

```bash
ansible-galaxy collection install kewlfft.aur
ansible-galaxy collection install community.general
```

4. **User with sudo privileges**

## Quick Start

**Note:** The playbook now includes system initialization roles (locale, hostname, bootloader, user-config) that configure fundamental system settings based on the manual installation guide. These are configured with sensible defaults:
- **Timezone**: Europe/Brussels
- **Locale**: en_US.UTF-8
- **Hostname**: archframe
- **Bootloader**: rEFInd (UEFI) or GRUB (BIOS)

You can skip these with `--skip-tags init` if your system is already configured.

### Full Installation

Run everything with interactive sudo password prompt:

```bash
cd ~/.ansible
ansible-playbook site.yml --ask-become-pass
```

### Dry Run (Check Mode)

Preview changes without making them:

```bash
ansible-playbook site.yml --check --ask-become-pass
```

### Selective Installation

Run only specific roles using tags:

```bash
# Install only base system and terminal tools
ansible-playbook site.yml --tags "base,terminal" --ask-become-pass

# Install only desktop environment
ansible-playbook site.yml --tags "desktop" --ask-become-pass

# Install only programming tools
ansible-playbook site.yml --tags "programming,python" --ask-become-pass
```

## Available Tags

| Tag | Description |
|-----|-------------|
| `init` | System initialization (all of: locale, hostname, bootloader, user-config) |
| `locale` | Timezone (Europe/Brussels) and locale (en_US.UTF-8) configuration |
| `hostname` | Hostname configuration (archframe) |
| `bootloader` | Bootloader setup (rEFInd for UEFI, GRUB for BIOS) |
| `user-config` | User configuration and sudo setup |
| `base` | Core system packages (make, cmake, git, yay) |
| `terminal` | Terminal emulator and CLI tools |
| `filesystems` | Filesystem drivers (NTFS, ExFAT, CIFS, etc.) |
| `xorg` | X11 server and utilities |
| `desktop` | Window manager (dwm), display manager (lightdm) |
| `themes` | GTK/Qt themes and appearance |
| `fonts` | Font packages |
| `audio` | Audio system (ALSA, PulseAudio) |
| `networking` | NetworkManager, VPN, SSH, Bluetooth |
| `printing` | CUPS and printer support |
| `gui-apps` | GUI applications (file manager, PDF reader, etc.) |
| `media` | Media applications (image/video viewers and editors) |
| `office` | Office applications (LibreOffice, Pandoc) |
| `browsers` | Web browsers |
| `email` | Email clients (Thunderbird, neomutt) |
| `programming` | Development tools (VS Code, Python, Rust) |
| `python` | Python packages and tools |
| `password-manager` | pass and related tools |
| `shells` | Shell configuration (zsh, autojump, etc.) |
| `custom-builds` | Custom builds (dwm, st, dmenu, scroll) |
| `web-services` | Web services (nginx, syncthing) |
| `system-config` | System-wide configuration |

## Structure

```
.ansible/
├── ansible.cfg           # Ansible configuration
├── site.yml             # Main playbook
├── inventory/
│   └── hosts            # Inventory file (localhost)
├── group_vars/          # Group variables (if needed)
├── host_vars/           # Host-specific variables (if needed)
└── roles/               # Role-based organization
    ├── locale/          # Timezone and locale
    ├── hostname/        # Hostname configuration
    ├── bootloader/      # rEFInd/GRUB setup
    ├── user-config/     # User and sudo setup
    ├── base/            # Base system setup
    ├── terminal/        # Terminal and CLI tools
    ├── xorg/            # X11 configuration
    ├── desktop/         # Desktop environment
    ├── themes/          # Themes and appearance
    ├── fonts/           # Font packages
    ├── audio/           # Audio system
    ├── networking/      # Network configuration
    ├── printing/        # Printer support
    ├── gui-apps/        # GUI applications
    ├── media/           # Media applications
    ├── office/          # Office suite
    ├── browsers/        # Web browsers
    ├── email/           # Email clients
    ├── programming/     # Development tools
    ├── python/          # Python packages
    ├── password-manager/# Pass password manager
    ├── shells/          # Shell configuration
    ├── custom-builds/   # Custom software builds
    ├── web-services/    # Web services
    └── system-config/   # System configuration
```

Each role contains:
- `tasks/main.yml` - Task definitions
- `templates/` - Jinja2 templates (for service files, configs)
- `defaults/` - Default variables
- `handlers/` - Event handlers

## Customization

### Skip Specific Roles

Use `--skip-tags` to exclude roles:

```bash
ansible-playbook site.yml --skip-tags "office,printing" --ask-become-pass
```

### Modify Variables

Edit `group_vars/all.yml` or `host_vars/localhost.yml` to customize:

```yaml
# Example: Override default user
user_name: myusername
home_dir: /home/myusername
```

### Disable Specific Packages

Comment out packages in role task files. For example, in `roles/terminal/tasks/main.yml`:

```yaml
# - name: Install calcurse
#   community.general.pacman:
#     name: calcurse
#     state: present
```

## Differences from Original Script

### Advantages

1. **Idempotency**: Ansible automatically checks if packages are installed
2. **Better error handling**: Failed tasks don't break the entire run
3. **Dry-run support**: `--check` mode to preview changes
4. **Parallel execution**: Some tasks can run in parallel
5. **Better logging**: Ansible provides detailed output
6. **No password storage**: Uses SSH keys or `--ask-become-pass`

### Notable Changes

1. **No FORCE flag**: Ansible's idempotency makes this unnecessary
2. **Systemd services**: Templates are used instead of inline sed commands
3. **AUR packages**: Requires `kewlfft.aur` collection
4. **Git submodules**: Handled via standard git module

## Troubleshooting

### AUR Package Installation Fails

Install the AUR collection:

```bash
ansible-galaxy collection install kewlfft.aur
```

### Permission Errors

Make sure you're using `--ask-become-pass`:

```bash
ansible-playbook site.yml --ask-become-pass
```

### Check Specific Role

Test a single role:

```bash
ansible-playbook site.yml --tags "base" --ask-become-pass -v
```

### Verbose Output

Add `-v`, `-vv`, or `-vvv` for increasing verbosity:

```bash
ansible-playbook site.yml --ask-become-pass -vv
```

## Advanced Usage

### Run on Remote Host

Edit `inventory/hosts`:

```ini
[archlinux]
myserver.example.com ansible_user=myuser
```

Then run:

```bash
ansible-playbook site.yml -i inventory/hosts --ask-become-pass
```

### Use Ansible Vault for Secrets

Store sensitive data encrypted:

```bash
ansible-vault create group_vars/secrets.yml
ansible-playbook site.yml --ask-vault-pass --ask-become-pass
```

### Generate Report

Save output to file:

```bash
ansible-playbook site.yml --ask-become-pass | tee install-$(date +%Y%m%d).log
```

## Maintenance

### Update System

Run the playbook again to update packages:

```bash
ansible-playbook site.yml --tags "update" --ask-become-pass
```

### Rebuild Custom Software

```bash
ansible-playbook site.yml --tags "custom-builds" --ask-become-pass
```

## Contributing

To add new packages or roles:

1. Create or modify role in `roles/`
2. Add tasks to `tasks/main.yml`
3. Update `site.yml` if adding a new role
4. Add appropriate tags
5. Document in this README

## Original Script

The original bash script is located at `.install/arch_install`. This Ansible setup provides the same functionality with improved automation and maintainability.

## Notes

- Some packages are commented out in the original script and are not included here
- Custom service files need to exist in `~/.install/services/` for service creation tasks to work
- The playbook assumes submodules are already initialized in `~/.build/`
- Some configurations may need manual adjustment based on your hardware (e.g., graphics drivers)

## License

Same as the original dotfiles repository.
