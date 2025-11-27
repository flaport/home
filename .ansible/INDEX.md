# Ansible Setup - Documentation Index

Welcome to the Arch Linux Ansible setup! This index helps you navigate the documentation.

## 🚀 Getting Started

**New to this setup?** Start here:

1. **[OVERVIEW.md](OVERVIEW.md)** - Visual guide with diagrams and workflows
2. **[QUICKSTART.md](QUICKSTART.md)** - Get up and running in 5 minutes
3. **[README.md](README.md)** - Complete documentation with all features
4. **[Makefile](Makefile)** - Convenient commands for common tasks

## 📚 Documentation Files

### Essential Reading

- **[OVERVIEW.md](OVERVIEW.md)**
  - Visual structure diagrams
  - Execution flow charts
  - Decision trees
  - Quick reference card
  - *Perfect for visual learners!*

- **[QUICKSTART.md](QUICKSTART.md)**
  - Prerequisites and installation
  - Common use cases
  - Quick troubleshooting
  - *Get running in 5 minutes!*

- **[README.md](README.md)**
  - Complete feature documentation
  - All available tags
  - Customization guide
  - Advanced usage
  - *Reference guide*

- **[INIT_ROLES.md](INIT_ROLES.md)**
  - System initialization roles explained
  - Post-installation automation
  - Locale, hostname, bootloader, user setup
  - Configuration and customization
  - *NEW: Automates manual install steps*

### Understanding the Structure

- **[STRUCTURE.md](STRUCTURE.md)**
  - Directory layout explained
  - Role descriptions
  - Usage patterns
  - How to extend
  - *For developers*

### Migration from Bash

- **[CONVERSION_NOTES.md](CONVERSION_NOTES.md)**
  - Bash vs Ansible comparisons
  - Key conversions explained
  - Why Ansible is better
  - Migration strategy
  - *For bash script users*

- **[COMPARISON.md](COMPARISON.md)**
  - Side-by-side feature comparison
  - Code examples
  - Performance benchmarks
  - When to use each approach
  - *Detailed comparison*

### Problem Solving

- **[TROUBLESHOOTING.md](TROUBLESHOOTING.md)**
  - Common issues and solutions
  - Debugging techniques
  - Performance tips
  - Getting help
  - *When things go wrong*

## 📁 Key Files

### Configuration

- **[ansible.cfg](ansible.cfg)** - Ansible configuration
- **[inventory/hosts](inventory/hosts)** - Target hosts
- **[requirements.yml](requirements.yml)** - Required collections
- **[site.yml](site.yml)** - Main playbook (entry point)

### Convenience

- **[Makefile](Makefile)** - Easy-to-use commands
  ```bash
  make help        # Show all available commands
  make install     # Full installation
  make check       # Dry-run
  make base        # Install base only
  ```

## 🎯 Quick Navigation by Task

### "I want to install everything"
→ Start with [QUICKSTART.md](QUICKSTART.md)
```bash
make install
```

### "I want to install specific components"
→ See [README.md](README.md) tags section
```bash
ansible-playbook site.yml --tags "base,terminal" --ask-become-pass
```

### "Something broke"
→ Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

### "How does this work?"
→ Read [STRUCTURE.md](STRUCTURE.md)

### "How is this different from the bash script?"
→ See [CONVERSION_NOTES.md](CONVERSION_NOTES.md)

### "I want to customize this"
→ See [README.md](README.md) customization section

## 🗂️ Roles Overview

The setup is organized into these roles:

| Category | Roles | Description |
|----------|-------|-------------|
| **Core** | base, terminal, filesystems | Essential system components |
| **GUI** | xorg, desktop, themes, fonts | Graphical environment |
| **System** | audio, networking, printing | System services |
| **Apps** | gui-apps, media, office, browsers, email | Applications |
| **Dev** | programming, python, password-manager | Development tools |
| **Custom** | shells, custom-builds, web-services, system-config | Customization |

See [STRUCTURE.md](STRUCTURE.md) for detailed role descriptions.

## 📋 Common Workflows

### First-Time Setup
```bash
# 1. Install prerequisites
sudo pacman -S ansible
make requirements

# 2. Preview what will happen
make check

# 3. Install everything
make install
```

### Update System
```bash
# Run the playbook again - it's idempotent!
make install
```

### Install Specific Components
```bash
# Just the base system
make base

# Desktop environment
make desktop

# Development tools
make programming
```

### Troubleshooting
```bash
# Dry-run to see what would change
make check

# Verbose output for debugging
make install VERBOSE=1

# Test specific role
ansible-playbook site.yml --tags "base" --ask-become-pass -vv
```

## 🔧 File Counts

```
35 total files created:
├── 6 documentation files (*.md)
├── 1 Makefile
├── 4 configuration files (*.yml, *.cfg, hosts)
├── 19 role task files (*/tasks/main.yml)
├── 5 service templates (*.service.j2)
```

## 📊 Statistics

- **19 roles** covering all aspects of system setup
- **400+ packages** managed across all roles
- **100% compatible** with original bash script functionality
- **Idempotent** - safe to run multiple times
- **Tagged** - install only what you need

## 🎓 Learning Path

### Beginner
1. Read [QUICKSTART.md](QUICKSTART.md)
2. Run `make check` to preview
3. Run `make base` for minimal install
4. Expand with more roles as needed

### Intermediate
1. Read [README.md](README.md) completely
2. Understand tags and selective installation
3. Customize roles for your needs
4. Use [TROUBLESHOOTING.md](TROUBLESHOOTING.md) when needed

### Advanced
1. Study [STRUCTURE.md](STRUCTURE.md)
2. Compare with [CONVERSION_NOTES.md](CONVERSION_NOTES.md)
3. Create custom roles
4. Extend for multiple machines

## 🔗 External Resources

- **Arch Wiki**: https://wiki.archlinux.org/
- **Ansible Docs**: https://docs.ansible.com/
- **AUR Collection**: https://github.com/kewlfft/ansible-aur
- **Original Script**: [../.install/arch_install](../.install/arch_install)

## 💡 Tips

1. **Always use `--check` first** to preview changes
2. **Use tags** to install selectively
3. **Read error messages** - they're usually helpful
4. **Check logs** with `journalctl` and `systemctl status`
5. **Start small** - install base first, then expand
6. **It's safe to re-run** - the playbook is idempotent

## 🆘 Need Help?

1. Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
2. Run with verbose output: `make install VERBOSE=1`
3. Test in check mode: `make check`
4. Review role tasks in `roles/*/tasks/main.yml`
5. Consult Arch Wiki for package-specific issues

## 📝 Quick Command Reference

```bash
# Setup
make requirements          # Install Ansible collections

# Installation
make install              # Full installation
make check               # Dry-run
make base                # Base system only
make terminal            # Terminal tools only
make desktop             # Desktop environment
make programming         # Development tools

# Debugging
make install VERBOSE=1   # Verbose output
ansible-playbook site.yml --list-tasks    # List all tasks
ansible-playbook site.yml --list-tags     # List all tags

# Selective
ansible-playbook site.yml --tags "base,terminal" --ask-become-pass
ansible-playbook site.yml --skip-tags "office" --ask-become-pass
```

## 🎉 Ready to Start?

→ Go to [QUICKSTART.md](QUICKSTART.md) and begin!

---

**Last Updated**: 2024
**Original Script**: `.install/arch_install`
**Conversion**: Bash → Ansible (Complete)
