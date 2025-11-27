# Troubleshooting Guide

Common issues and solutions when using the Ansible playbook.

## Installation Issues

### "No module named kewlfft.aur"

**Problem:** AUR module not installed

**Solution:**
```bash
ansible-galaxy collection install kewlfft.aur
# or
make requirements
```

---

### "community.general not found"

**Problem:** Required collection not installed

**Solution:**
```bash
ansible-galaxy collection install community.general
# or
make requirements
```

---

### "Permission denied" errors

**Problem:** Not using sudo/become

**Solution:**
Always use `--ask-become-pass`:
```bash
ansible-playbook site.yml --ask-become-pass
# or
make install  # Already includes --ask-become-pass
```

---

### "Failed to lock database"

**Problem:** Another package manager process is running

**Solution:**
1. Wait for other pacman operations to complete
2. Kill stuck pacman processes:
```bash
sudo killall pacman
sudo rm /var/lib/pacman/db.lck
```

---

## AUR Package Issues

### yay not installed

**Problem:** Trying to install AUR packages before yay is installed

**Solution:**
Run base role first:
```bash
ansible-playbook site.yml --tags "base" --ask-become-pass
```

---

### AUR build fails

**Problem:** Build dependencies missing or compilation errors

**Solution:**
1. Install base-devel:
```bash
sudo pacman -S base-devel
```

2. Check build logs manually:
```bash
yay -S package-name
```

3. Skip problematic AUR packages:
```bash
ansible-playbook site.yml --skip-tags "custom-builds" --ask-become-pass
```

---

## Service Issues

### Service template not found

**Problem:** Service template references non-existent source file

**Solution:**
Templates look for files in `~/.install/services/`. Either:
1. Create the service file there
2. Or comment out the service creation task

Example:
```yaml
# In roles/terminal/tasks/main.yml
# - name: Create tmux systemd service
#   ansible.builtin.template:
#     src: tmux.service.j2
#     dest: /etc/systemd/system/tmux@.service
```

---

### Service fails to start

**Problem:** Service configuration error

**Solution:**
1. Check service status:
```bash
sudo systemctl status service-name
```

2. View logs:
```bash
sudo journalctl -u service-name -n 50
```

3. Test manually:
```bash
sudo systemctl start service-name
```

---

## Custom Build Issues

### Submodule not found

**Problem:** Git submodules not initialized

**Solution:**
```bash
cd ~
git submodule update --init --recursive
```

---

### Build fails (dwm, st, dmenu, scroll)

**Problem:** Missing build dependencies or configuration

**Solution:**
1. Install build dependencies:
```bash
ansible-playbook site.yml --tags "base" --ask-become-pass
```

2. Check submodule exists:
```bash
ls ~/.build/dwm
ls ~/.build/st
ls ~/.build/dmenu
ls ~/.build/scroll
```

3. Build manually to see errors:
```bash
cd ~/.build/dwm
sudo make clean
sudo make all
```

---

## Networking Issues

### NetworkManager not starting

**Problem:** Conflicting network managers

**Solution:**
Disable other network managers:
```bash
sudo systemctl disable systemd-networkd
sudo systemctl disable dhcpcd
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager
```

---

### VPN connection fails

**Problem:** OpenVPN config file not found

**Solution:**
Place config files in:
```bash
~/.config/openvpn/connection-name.ovpn
```

Then start with:
```bash
sudo systemctl start openvpn@connection-name
```

---

## Display/Graphics Issues

### X11 won't start

**Problem:** Display driver issues

**Solution:**
1. Check Xorg logs:
```bash
cat /var/log/Xorg.0.log
```

2. Test X11:
```bash
startx
```

3. Install appropriate drivers (in `site.yml` hardware acceleration section)

---

### LightDM doesn't show up

**Problem:** Display manager not enabled or configured

**Solution:**
```bash
sudo systemctl enable lightdm
sudo systemctl start lightdm
```

---

### dwm doesn't appear in lightdm

**Problem:** Desktop file missing

**Solution:**
1. Check if file exists:
```bash
ls /usr/share/xsessions/dwm.desktop
```

2. Create it manually:
```bash
sudo cp ~/.local/share/applications/dwm.desktop /usr/share/xsessions/
```

---

## Font Issues

### Fonts not appearing

**Problem:** Font cache not updated

**Solution:**
```bash
fc-cache -fv
```

---

### Emoji not showing

**Problem:** Emoji fonts not installed or font config blocking

**Solution:**
1. Install emoji fonts:
```bash
ansible-playbook site.yml --tags "fonts" --ask-become-pass
```

2. Check font config:
```bash
ls ~/.config/fontconfig/conf.d/
```

3. Remove blocking configs if needed

---

## Python Issues

### Module not found

**Problem:** Python package not installed

**Solution:**
Install via Ansible:
```bash
ansible-playbook site.yml --tags "python" --ask-become-pass
```

Or manually:
```bash
sudo pacman -S python-package-name
```

---

### pip permission errors

**Problem:** Trying to install system-wide without sudo

**Solution:**
Use system package manager (pacman) instead of pip for system packages.

For user packages:
```bash
pip install --user package-name
```

---

## SSH Issues

### SSH X11 forwarding not working

**Problem:** X11Forwarding not enabled

**Solution:**
1. Check config:
```bash
grep X11Forwarding /etc/ssh/sshd_config
```

2. Enable it:
```bash
ansible-playbook site.yml --tags "networking" --ask-become-pass
```

3. Restart sshd:
```bash
sudo systemctl restart sshd
```

---

## Ansible Issues

### "Undefined variable"

**Problem:** Variable not set

**Solution:**
Variables `user_name` and `home_dir` are auto-detected. Check with:
```bash
ansible localhost -m debug -a "var=ansible_user_id"
ansible localhost -m debug -a "var=ansible_env.HOME"
```

---

### Task hangs

**Problem:** Waiting for input or stuck process

**Solution:**
1. Press Ctrl+C to see where it's stuck
2. Add `-vvv` for verbose output:
```bash
ansible-playbook site.yml --ask-become-pass -vvv
```

---

### "changed" status every time

**Problem:** Task not idempotent

**Solution:**
This is expected for some tasks (like git pulls, builds). If bothersome:
```yaml
changed_when: false  # Add to task
```

---

## Performance Issues

### Playbook runs slowly

**Problem:** Sequential execution, many packages

**Solution:**
1. Run only needed roles:
```bash
ansible-playbook site.yml --tags "base,terminal" --ask-become-pass
```

2. Skip already configured:
```bash
ansible-playbook site.yml --skip-tags "fonts,office" --ask-become-pass
```

3. Use `--check` mode first to see what would run

---

### AUR builds take forever

**Problem:** Compiling from source

**Solution:**
1. Use binary packages when available (check AUR for `-bin` versions)
2. Or skip AUR packages:
```bash
# Comment out specific packages in role tasks
```

---

## General Debugging

### See what would change

```bash
ansible-playbook site.yml --check --diff --ask-become-pass
```

### Run with verbose output

```bash
ansible-playbook site.yml --ask-become-pass -vvv
```

### Test single role

```bash
ansible-playbook site.yml --tags "base" --ask-become-pass -vv
```

### Syntax check

```bash
ansible-playbook site.yml --syntax-check
```

### List all tasks

```bash
ansible-playbook site.yml --list-tasks
```

### List all tags

```bash
ansible-playbook site.yml --list-tags
```

---

## Getting Help

1. **Check logs**: Look in `/var/log/` and `journalctl`
2. **Verbose mode**: Run with `-vvv`
3. **Check mode**: Use `--check` to preview
4. **Arch Wiki**: https://wiki.archlinux.org/
5. **Ansible docs**: https://docs.ansible.com/

---

## Clean Start

If things are really broken, try a clean run:

```bash
# Remove retry files
cd ~/.ansible
rm -f *.retry

# Run base only
ansible-playbook site.yml --tags "base" --ask-become-pass -vv

# Then add more
ansible-playbook site.yml --tags "base,terminal" --ask-become-pass -vv

# Continue incrementally
```

---

## Reverting Changes

Ansible doesn't have built-in rollback. To undo:

1. **Packages**: Remove with pacman/yay
2. **Services**: Disable with systemctl
3. **Files**: Restore from backups in `~/.local/share/arch_install.log`
4. **Config**: Revert using git (if dotfiles are in git)

---

## Common Patterns

### Skip problematic package

Comment it out in the role:
```yaml
# - name: Install problematic-package
#   community.general.pacman:
#     name: problematic-package
#     state: present
```

### Add package

Add to appropriate role:
```yaml
- name: Install my-package
  community.general.pacman:
    name: my-package
    state: present
```

### Conditional installation

```yaml
- name: Install optional-package
  community.general.pacman:
    name: optional-package
    state: present
  when: install_optional | default(false)
```

Then run with:
```bash
ansible-playbook site.yml --extra-vars "install_optional=true" --ask-become-pass
```
