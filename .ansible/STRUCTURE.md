# Ansible Structure Overview

This document provides an overview of the Ansible setup structure.

## Directory Layout

```
.ansible/
├── ansible.cfg              # Ansible configuration
├── site.yml                 # Main playbook - entry point
├── requirements.yml         # Required Ansible collections
├── Makefile                 # Convenience commands
├── README.md               # Complete documentation
├── QUICKSTART.md           # Quick start guide
├── STRUCTURE.md            # This file
├── .gitignore              # Git ignore patterns
│
├── inventory/
│   └── hosts               # Inventory definition (localhost)
│
└── roles/                  # All roles
    │
    ├── locale/             # Timezone and locale configuration
    │   └── tasks/main.yml
    │
    ├── hostname/           # Hostname configuration
    │   └── tasks/main.yml
    │
    ├── user-config/        # User and sudo configuration
    │   └── tasks/main.yml
    │
    ├── base/               # Build tools, git, yay AUR helper
    │   └── tasks/main.yml
    │
    ├── terminal/           # Terminal emulator, CLI tools, neovim
    │   ├── tasks/main.yml
    │   └── templates/
    │       ├── tmux.service.j2
    │       └── pacmanquery.service.j2
    │
    ├── filesystems/        # NTFS, ExFAT, CIFS, WebDAV drivers
    │   └── tasks/main.yml
    │
    ├── xorg/              # X11 server and utilities
    │   └── tasks/main.yml
    │
    ├── desktop/           # Window manager, lightdm, notifications
    │   └── tasks/main.yml
    │
    ├── themes/            # GTK/Qt themes
    │   └── tasks/main.yml
    │
    ├── fonts/             # Font packages
    │   └── tasks/main.yml
    │
    ├── audio/             # ALSA and PulseAudio
    │   └── tasks/main.yml
    │
    ├── networking/        # NetworkManager, VPN, SSH, Bluetooth
    │   ├── tasks/main.yml
    │   └── templates/
    │       └── openvpn.service.j2
    │
    ├── printing/          # CUPS printer support
    │   └── tasks/main.yml
    │
    ├── gui-apps/          # Nemo, arandr, zathura, etc.
    │   └── tasks/main.yml
    │
    ├── media/             # Image/video tools (inkscape, mpv, etc.)
    │   └── tasks/main.yml
    │
    ├── office/            # LibreOffice, pandoc
    │   └── tasks/main.yml
    │
    ├── browsers/          # Web browsers
    │   └── tasks/main.yml
    │
    ├── email/             # Thunderbird, neomutt, mbsync
    │   └── tasks/main.yml
    │
    ├── programming/       # VS Code, Python, Rust toolchains
    │   └── tasks/main.yml
    │
    ├── python/            # Python packages and libraries
    │   ├── tasks/main.yml
    │   └── templates/
    │       └── jupyterhub.service.j2
    │
    ├── password-manager/  # pass, browserpass, gpg
    │   └── tasks/main.yml
    │
    ├── shells/            # zsh, autojump, syntax highlighting
    │   └── tasks/main.yml
    │
    ├── custom-builds/     # dwm, st, dmenu, scroll
    │   └── tasks/main.yml
    │
    ├── web-services/      # nginx, syncthing
    │   ├── tasks/main.yml
    │   └── templates/
    │       └── syncthing.service.j2
    │
    └── system-config/     # System-wide settings
        └── tasks/main.yml
```

## Role Descriptions

### Core System

- **base**: Essential build tools, git configuration, yay AUR helper
- **terminal**: Terminal emulator (alacritty), CLI tools, tmux, neovim
- **filesystems**: Support for various filesystems (NTFS, ExFAT, etc.)

### Graphical Environment

- **xorg**: X11 server and utilities
- **desktop**: Window manager (dwm), display manager (lightdm), notifications
- **themes**: GTK and Qt themes, appearance settings
- **fonts**: Font packages including emoji and icon fonts

### System Services

- **audio**: Audio system (ALSA, PulseAudio)
- **networking**: Network configuration, VPN, SSH, Bluetooth
- **printing**: Printer support via CUPS
- **web-services**: nginx, syncthing, etc.

### Applications

- **gui-apps**: Essential GUI tools (file manager, PDF reader, etc.)
- **media**: Media viewers and editors
- **office**: Office suite and document tools
- **browsers**: Web browsers
- **email**: Email clients and sync tools

### Development

- **programming**: Development tools and IDEs
- **python**: Python packages and tools
- **password-manager**: Password management with pass

### Customization

- **shells**: Shell configuration (zsh, plugins)
- **custom-builds**: Personal forks of dwm, st, dmenu, scroll
- **system-config**: System-wide configuration

## Key Features

1. **Idempotent**: Safe to run multiple times
2. **Modular**: Each role is independent
3. **Tagged**: Run specific parts selectively
4. **Templated**: Service files use Jinja2 templates
5. **Well-organized**: Clear separation of concerns

## Usage Patterns

### Full Installation
```bash
make install
```

### Selective Installation
```bash
ansible-playbook site.yml --tags "base,terminal,desktop" --ask-become-pass
```

### Update Specific Component
```bash
ansible-playbook site.yml --tags "custom-builds" --ask-become-pass
```

### Dry Run
```bash
make check
```

## Extending

To add new functionality:

1. Create a new role in `roles/`
2. Add tasks in `roles/ROLE_NAME/tasks/main.yml`
3. Include the role in `site.yml`
4. Add appropriate tags
5. Update documentation

## Variables

Common variables used across roles:
- `user_name`: Current user (automatically detected)
- `home_dir`: User's home directory (automatically detected)

Add custom variables in:
- `group_vars/all.yml` (for all hosts)
- `host_vars/localhost.yml` (for local machine)

## Service Templates

Service files are templated using Jinja2:
- Variables like `{{ user_name }}` are substituted at runtime
- Templates are in `roles/ROLE_NAME/templates/`
- Deployed to `/etc/systemd/system/`

## Migration from Bash Script

The original bash script (`.install/arch_install`) has been converted to this Ansible structure:

| Bash Section | Ansible Role |
|--------------|--------------|
| Update | base (update task) |
| Build tools | base |
| Git | base |
| yay | base |
| Terminal tools | terminal |
| Xorg | xorg |
| Desktop/WM | desktop |
| Themes | themes |
| Fonts | fonts |
| Audio | audio |
| Network | networking |
| Printers | printing |
| GUI apps | gui-apps |
| Media | media |
| Office | office |
| Browsers | browsers |
| Email | email |
| Programming | programming |
| Python | python |
| Password manager | password-manager |
| Shells | shells |
| Custom builds | custom-builds |
| Web services | web-services |
| System config | system-config |

## Advantages Over Bash Script

1. **No manual "already installed" checks** - Ansible handles this
2. **Better error recovery** - Failed tasks don't break everything
3. **Parallel execution** - Where possible
4. **Dry-run support** - Preview changes before applying
5. **Better logging** - Detailed output and error messages
6. **Reusable** - Roles can be shared across machines
7. **Type-safe** - Structured YAML instead of string manipulation
