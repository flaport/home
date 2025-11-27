# Quick Start Guide

## Prerequisites

```bash
# Install Ansible
sudo pacman -S ansible

# Install required collections
cd ~/.ansible
make requirements
# or manually:
ansible-galaxy collection install -r requirements.yml
```

## Installation

### Option 1: Using Make (Recommended)

```bash
cd ~/.ansible

# Preview what will be installed (dry-run)
make check

# Install everything
make install

# Install specific components
make base           # Base system only
make terminal       # Terminal tools only
make desktop        # Desktop environment only
make programming    # Development tools only
```

### Option 2: Using Ansible Directly

```bash
cd ~/.ansible

# Full installation
ansible-playbook site.yml --ask-become-pass

# Check mode (preview)
ansible-playbook site.yml --check --ask-become-pass

# Install specific tags
ansible-playbook site.yml --tags "base,terminal" --ask-become-pass

# Skip certain tags
ansible-playbook site.yml --skip-tags "office,printing" --ask-become-pass
```

## Common Use Cases

### Minimal Installation (Base + Terminal)

```bash
ansible-playbook site.yml --tags "base,terminal" --ask-become-pass
```

### Desktop Setup

```bash
ansible-playbook site.yml --tags "base,xorg,desktop,themes,fonts" --ask-become-pass
```

### Development Environment

```bash
ansible-playbook site.yml --tags "base,terminal,programming,python" --ask-become-pass
```

### Update Custom Builds (dwm, st, dmenu)

```bash
ansible-playbook site.yml --tags "custom-builds" --ask-become-pass
```

## Troubleshooting

### "Module not found: kewlfft.aur"

```bash
ansible-galaxy collection install kewlfft.aur
```

### Permission Denied

Always use `--ask-become-pass`:

```bash
ansible-playbook site.yml --ask-become-pass
```

### Verbose Output

Add `-vv` for detailed logs:

```bash
ansible-playbook site.yml --ask-become-pass -vv
```

## What Gets Installed?

Run this to see all available tags:

```bash
grep -E "^\s+tags:" site.yml
```

Or check the README.md for a complete list.
