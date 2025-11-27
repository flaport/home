# Visual Overview

A visual guide to understanding the Ansible setup structure and workflow.

## 🎯 Project Structure

```
.ansible/
│
├── 📋 Main Files
│   ├── site.yml              ← Entry point (main playbook)
│   ├── ansible.cfg           ← Ansible configuration
│   ├── requirements.yml      ← Dependencies
│   └── Makefile             ← Convenient commands
│
├── 📚 Documentation (7 files)
│   ├── INDEX.md             ← Start here! Navigation hub
│   ├── QUICKSTART.md        ← 5-minute setup guide
│   ├── README.md            ← Complete reference
│   ├── STRUCTURE.md         ← Architecture explained
│   ├── CONVERSION_NOTES.md  ← Bash → Ansible guide
│   ├── COMPARISON.md        ← Feature comparison
│   ├── TROUBLESHOOTING.md   ← Problem solving
│   └── OVERVIEW.md          ← This file
│
├── 🗂️ Inventory
│   └── inventory/hosts      ← Target machines
│
└── 🎭 Roles (19 roles)
    ├── 💻 Core System
    │   ├── base/            ← Build tools, git, yay
    │   ├── terminal/        ← CLI tools, tmux, neovim
    │   └── filesystems/     ← Disk drivers
    │
    ├── 🖥️ Graphical Environment
    │   ├── xorg/           ← X11 server
    │   ├── desktop/        ← Window manager, lightdm
    │   ├── themes/         ← GTK/Qt themes
    │   └── fonts/          ← Font packages
    │
    ├── ⚙️ System Services
    │   ├── audio/          ← Sound system
    │   ├── networking/     ← Network, VPN, SSH
    │   ├── printing/       ← Printer support
    │   └── web-services/   ← nginx, syncthing
    │
    ├── 📱 Applications
    │   ├── browsers/       ← Web browsers
    │   ├── gui-apps/       ← File manager, PDF reader
    │   ├── media/          ← Image/video tools
    │   ├── office/         ← LibreOffice
    │   └── email/          ← Email clients
    │
    ├── 👨‍💻 Development
    │   ├── programming/    ← VS Code, languages
    │   ├── python/         ← Python packages
    │   └── password-manager/ ← pass, gpg
    │
    └── 🎨 Customization
        ├── shells/         ← zsh, plugins
        ├── custom-builds/  ← dwm, st, dmenu
        └── system-config/  ← System settings
```

## 🔄 Execution Flow

```
┌─────────────────────────────────────────────────────────┐
│  User runs: make install                                │
│  or: ansible-playbook site.yml --ask-become-pass        │
└─────────────────┬───────────────────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────────────────────┐
│  ansible.cfg: Load configuration                        │
│  - Set roles path                                       │
│  - Configure privilege escalation                       │
│  - Set output format                                    │
└─────────────────┬───────────────────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────────────────────┐
│  site.yml: Main playbook                               │
│  - Define target hosts (localhost)                      │
│  - Set variables (user_name, home_dir)                 │
│  - Import roles in order                                │
└─────────────────┬───────────────────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────────────────────┐
│  Execute Roles (in order, unless tagged)                │
│                                                          │
│  1. base          → Build tools, git, yay              │
│  2. terminal      → CLI tools, neovim                  │
│  3. filesystems   → Disk drivers                       │
│  4. xorg          → X11 server                         │
│  5. desktop       → Window manager                     │
│  6. themes        → Appearance                         │
│  7. fonts         → Font packages                      │
│  8. audio         → Sound system                       │
│  9. networking    → Network setup                      │
│  10. printing     → Printer support                    │
│  11. gui-apps     → GUI applications                   │
│  12. media        → Media tools                        │
│  13. office       → Office suite                       │
│  14. browsers     → Web browsers                       │
│  15. email        → Email clients                      │
│  16. programming  → Dev tools                          │
│  17. python       → Python packages                    │
│  18. password-manager → Pass setup                     │
│  19. shells       → Shell config                       │
│  20. custom-builds → dwm, st, dmenu                   │
│  21. web-services → nginx, syncthing                  │
│  22. system-config → Final settings                   │
└─────────────────┬───────────────────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────────────────────┐
│  Each Role Executes:                                    │
│  ├── Read tasks/main.yml                               │
│  ├── Process each task sequentially                    │
│  ├── Check if change needed (idempotency)              │
│  ├── Apply changes if needed                           │
│  ├── Report: ok | changed | failed                     │
│  └── Continue to next task                             │
└─────────────────┬───────────────────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────────────────────┐
│  Final Report:                                          │
│  - Summary of all changes                               │
│  - Count: ok / changed / unreachable / failed          │
│  - Execution time                                       │
└─────────────────────────────────────────────────────────┘
```

## 🏷️ Tag-Based Execution

```
                     ┌──────────────┐
                     │  site.yml    │
                     │  (all roles) │
                     └──────┬───────┘
                            │
              ┌─────────────┼─────────────┐
              │             │             │
        [base tag]    [desktop tag]  [all tags]
              │             │             │
              ▼             ▼             ▼
         ┌────────┐    ┌────────┐    ┌────────┐
         │  base  │    │  xorg  │    │   ALL  │
         └────────┘    │desktop │    │  ROLES │
                       │ themes │    └────────┘
                       │  fonts │
                       └────────┘

Usage:
  ansible-playbook site.yml --tags "base"
  ansible-playbook site.yml --tags "desktop"
  ansible-playbook site.yml  (no tags = all)
```

## 🎭 Role Anatomy

```
roles/terminal/
│
├── tasks/
│   └── main.yml          ← Task definitions
│       │
│       ├── Install packages
│       ├── Configure services
│       ├── Create symlinks
│       └── Apply settings
│
├── templates/            ← Jinja2 templates
│   ├── tmux.service.j2       (systemd service)
│   └── config.j2             (config file)
│
├── files/                ← Static files
│   └── script.sh
│
├── defaults/             ← Default variables
│   └── main.yml
│
└── handlers/             ← Event handlers
    └── main.yml              (restart services)
```

## 📊 Package Installation Flow

```
Task: Install Package
        │
        ▼
┌───────────────────┐
│ Check if package  │
│ already installed │
└─────┬─────────────┘
      │
      ├─ Yes → ┌────────────┐
      │        │ Skip (ok)  │
      │        └────────────┘
      │
      └─ No  → ┌────────────────┐
               │ Install package│
               └─────┬──────────┘
                     │
                     ├─ Success → ┌──────────────┐
                     │            │ Report change│
                     │            └──────────────┘
                     │
                     └─ Failure → ┌──────────────┐
                                  │ Report error │
                                  │ Stop or Skip │
                                  └──────────────┘
```

## 🔧 Common Workflows

### Full Installation
```
User → make install
       │
       ├─ Read requirements.yml
       ├─ Check Ansible collections
       ├─ Run site.yml
       ├─ Execute all 19 roles
       └─ Report results
```

### Selective Installation
```
User → ansible-playbook site.yml --tags "base,terminal"
       │
       ├─ Skip untagged roles
       ├─ Run only 'base' role
       ├─ Run only 'terminal' role
       └─ Report results (faster!)
```

### Dry-Run
```
User → make check
       │
       ├─ Run with --check flag
       ├─ Simulate all changes
       ├─ NO actual modifications
       └─ Report what WOULD change
```

### Debugging
```
User → make install VERBOSE=1
       │
       ├─ Run with -vv flag
       ├─ Show detailed output
       ├─ Display all commands
       └─ Show variable values
```

## 🔀 Decision Tree: Which Command?

```
┌─────────────────────────┐
│ What do you want to do? │
└────────┬────────────────┘
         │
         ├─ First time setup?
         │  └─→ make requirements → make check → make install
         │
         ├─ Install everything?
         │  └─→ make install
         │
         ├─ Just preview changes?
         │  └─→ make check
         │
         ├─ Install specific parts?
         │  └─→ ansible-playbook site.yml --tags "base,terminal"
         │
         ├─ Update existing system?
         │  └─→ make install (safe, idempotent)
         │
         ├─ Fix one thing?
         │  └─→ ansible-playbook site.yml --tags "networking"
         │
         ├─ Debugging issues?
         │  └─→ make install VERBOSE=1
         │
         └─ Need help?
            └─→ Read TROUBLESHOOTING.md
```

## 📈 Complexity Levels

```
┌─────────────┬──────────────────────────────────────┐
│ BEGINNER    │ make install                         │
│             │ make check                           │
│             │ Read QUICKSTART.md                   │
├─────────────┼──────────────────────────────────────┤
│ INTERMEDIATE│ --tags "base,terminal"               │
│             │ --skip-tags "office"                 │
│             │ Edit role tasks                      │
│             │ Read README.md                       │
├─────────────┼──────────────────────────────────────┤
│ ADVANCED    │ Create custom roles                  │
│             │ Use templates and variables          │
│             │ Multi-host deployment                │
│             │ Read STRUCTURE.md                    │
└─────────────┴──────────────────────────────────────┘
```

## 🎨 Component Dependencies

```
base (must run first)
  │
  ├─→ terminal (needs base tools)
  │     │
  │     ├─→ shells (needs terminal)
  │     └─→ programming (needs terminal)
  │
  ├─→ xorg (needs base)
  │     │
  │     └─→ desktop (needs xorg)
  │           │
  │           ├─→ themes (needs desktop)
  │           ├─→ fonts (needs desktop)
  │           └─→ gui-apps (needs desktop)
  │
  └─→ networking (relatively independent)
        │
        └─→ email (needs networking)
```

## 📦 File Types

```
.yml files    → Playbooks, tasks, config
.j2 files     → Jinja2 templates (services, configs)
.md files     → Documentation
.cfg file     → Ansible configuration
Makefile      → Convenience commands
hosts         → Inventory definition
```

## 🚀 Quick Reference Card

```
┌────────────────────────────────────────────────────────┐
│ QUICK COMMANDS                                         │
├────────────────────────────────────────────────────────┤
│ Setup:                                                 │
│   make requirements     Install Ansible collections    │
│                                                        │
│ Installation:                                          │
│   make check           Preview changes (dry-run)      │
│   make install         Full installation              │
│   make base            Base system only               │
│   make terminal        Terminal tools only            │
│   make desktop         Desktop environment only       │
│   make programming     Dev tools only                 │
│                                                        │
│ Advanced:                                              │
│   --tags "base,..."    Install specific roles         │
│   --skip-tags "..."    Skip specific roles            │
│   --check              Dry-run mode                   │
│   -vv                  Verbose output                 │
│   --list-tasks         Show all tasks                 │
│   --list-tags          Show all tags                  │
│                                                        │
│ Help:                                                  │
│   make help            Show available commands        │
│   INDEX.md             Documentation navigation       │
│   QUICKSTART.md        Quick setup guide              │
│   TROUBLESHOOTING.md   Problem solving                │
└────────────────────────────────────────────────────────┘
```

## 🎯 Success Metrics

After running the playbook, you should see:

```
PLAY RECAP *********************************************************
localhost    : ok=150  changed=45  unreachable=0  failed=0  ...
```

- ✅ **ok**: Tasks that succeeded (no change needed)
- ✅ **changed**: Tasks that made changes
- ❌ **failed**: Tasks that failed (investigate!)
- ⚠️ **unreachable**: Host connection issues

## 📊 Typical Run Time

```
┌──────────────────┬──────────┬─────────────┐
│ Operation        │ First    │ Subsequent  │
├──────────────────┼──────────┼─────────────┤
│ Full install     │ 40-60min │ 5-10min     │
│ Base only        │ 5min     │ 1min        │
│ Terminal only    │ 10min    │ 2min        │
│ Desktop only     │ 15min    │ 3min        │
│ Single package   │ 1min     │ 10sec       │
│ Check mode       │ 2-3min   │ 2-3min      │
└──────────────────┴──────────┴─────────────┘
```

## 🎓 Learning Path

```
1. Read INDEX.md          (5 min)
   └─→ Understand structure

2. Read QUICKSTART.md     (10 min)
   └─→ Get hands-on

3. Run: make check        (2 min)
   └─→ See what would happen

4. Run: make base         (5 min)
   └─→ Install minimal system

5. Explore roles          (20 min)
   └─→ See what's available

6. Install more           (variable)
   └─→ Add what you need

7. Read README.md         (30 min)
   └─→ Learn all features

8. Customize              (ongoing)
   └─→ Make it yours!
```

## 🎉 You're Ready!

Start with: [INDEX.md](INDEX.md) → [QUICKSTART.md](QUICKSTART.md) → `make install`

Questions? Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
