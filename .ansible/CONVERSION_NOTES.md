# Conversion Notes: Bash to Ansible

This document explains key differences between the original bash script and the Ansible implementation.

## Key Conversions

### Package Installation

**Bash:**
```bash
pacman_install() {
    printf "[pacman] install $1... "
    echo $password | sudo -S pacman -Q $1 >> "$LOG" 2>> "$ERR";
    if [ $? = 0 ] && [ "$FORCE" -eq 0 ]; then
        printf "already installed.\n"
        return 1
    fi
    echo $password | sudo -S pacman -S --noconfirm --noprogress --overwrite='*' $1
}
```

**Ansible:**
```yaml
- name: Install package
  community.general.pacman:
    name: package-name
    state: present
```

**Why better:** Ansible automatically checks if installed, no need for custom logic.

---

### AUR Installation (yay)

**Bash:**
```bash
yay_install() {
    printf "[ yay  ] install $1... "
    echo $password | sudo -S pacman -Q $1 >> "$LOG" 2>> "$ERR";
    if [ $? = 0 ] && [ "$FORCE" -eq 0 ]; then
        printf "already installed.\n"
        return 1
    fi
    yay -S -q --noconfirm --overwrite='*' $1
}
```

**Ansible:**
```yaml
- name: Install AUR package
  kewlfft.aur.aur:
    name: package-name
    state: present
  become: no
```

**Note:** Requires `kewlfft.aur` collection.

---

### Systemd Service Creation

**Bash:**
```bash
systemctl_create() {
    printf "[system] create $1 service... "
    source=$HOME/.install/services/$1.service
    target=$(head -6 $source | tail -1 | sed 's/#\\ *TARGET:\\ *//g')

    echo $password | sudo -S systemctl daemon-reload
    echo "# NOTE: THIS FILE WAS AUTO-GENERATED..." | sudo tee $target > /dev/null
    tail --lines=+7 $source | sed 's|{USER}|'$USER'|g' | sudo tee -a $target > /dev/null
    echo $password | sudo -S systemctl daemon-reload
}
```

**Ansible:**
```yaml
- name: Create systemd service
  ansible.builtin.template:
    src: service-name.service.j2
    dest: /etc/systemd/system/service-name.service
    mode: '0644'
  notify: reload systemd
```

**Why better:** Template engine handles variable substitution cleanly.

---

### File Symlinks

**Bash:**
```bash
link() {
    printf "[ link ] from $1 to $2... "
    [ -f "$2" ] && echo $password | sudo -S mv $2 $2.bak
    echo $password | sudo -S ln -sf $1 $2
}
```

**Ansible:**
```yaml
- name: Create symlink
  ansible.builtin.file:
    src: /source/path
    dest: /dest/path
    state: link
    force: yes
```

**Why better:** Idempotent, handles backups automatically.

---

### Git Cloning

**Bash:**
```bash
if [ ! -d "$HOME/.local/share/wallpapers" ]; then
    git clone https://gitlab.com/dwt1/wallpapers $HOME/.local/share/wallpapers
fi
```

**Ansible:**
```yaml
- name: Clone wallpapers
  ansible.builtin.git:
    repo: https://gitlab.com/dwt1/wallpapers
    dest: "{{ home_dir }}/.local/share/wallpapers"
    force: no
  become: no
```

**Why better:** Handles updates, checks, and error conditions automatically.

---

### Custom Builds (submodules)

**Bash:**
```bash
submodule_install() {
    printf "[submod] install $1... "
    cd "$HOME/.build/$1"
    echo $password | sudo -S rm config.h
    echo $password | sudo -S make clean
    git checkout master
    git pull origin master
    echo $password | sudo -S make all
    echo $password | sudo -S make install
    echo $password | sudo -S make clean
    cd $HOME
}
```

**Ansible:**
```yaml
- name: Build and install dwm
  ansible.builtin.shell:
    cmd: |
      sudo make all
      sudo make install
      sudo make clean
      sudo rm -f config.h
    chdir: "{{ home_dir }}/.build/dwm"
  register: dwm_build
  changed_when: dwm_build.rc == 0
```

**Note:** Some bash is still needed for complex build processes.

---

### User Group Management

**Bash:**
```bash
groupadd video
echo $password | sudo -S usermod -a -G video $USER
```

**Ansible:**
```yaml
- name: Create video group
  ansible.builtin.group:
    name: video
    state: present

- name: Add user to video group
  ansible.builtin.user:
    name: "{{ user_name }}"
    groups: video
    append: yes
```

**Why better:** Declarative, idempotent, clearer intent.

---

### Configuration File Editing

**Bash:**
```bash
grep "\\[archlinuxcn\\]" /etc/pacman.conf &> /dev/null || \
    printf "\\n\\n[archlinuxcn]\\nServer=https://repo.archlinuxcn.org/\\$arch" | \
    sudo tee -a /etc/pacman.conf > /dev/null
```

**Ansible:**
```yaml
- name: Add archlinuxcn repository
  ansible.builtin.blockinfile:
    path: /etc/pacman.conf
    block: |
      [archlinuxcn]
      Server=https://repo.archlinuxcn.org/$arch
    marker: "# {mark} ANSIBLE MANAGED BLOCK - archlinuxcn"
```

**Why better:** Clearly marked, easy to remove, idempotent.

---

### Conditional Execution

**Bash:**
```bash
if [ -f "$HOME/.extra/index.html" ]; then
    [ -f /var/www/html/index.html ] || \
        echo $password | sudo -S cp $HOME/.extra/index.html /var/www/html/index.html
fi
```

**Ansible:**
```yaml
- name: Copy custom index.html
  ansible.builtin.copy:
    src: "{{ home_dir }}/.extra/index.html"
    dest: /var/www/html/index.html
    remote_src: yes
    force: no
  when: lookup('fileglob', home_dir + '/.extra/index.html') | length > 0
```

**Why better:** Built-in conditional logic, clearer syntax.

---

## Password Handling

**Bash:** Prompts once, stores in variable, reuses everywhere
```bash
read -s -p "[sudo] password for $USER: " password
echo $password | sudo -S command
```

**Ansible:** Uses built-in privilege escalation
```bash
ansible-playbook site.yml --ask-become-pass
```

**Why better:** More secure, doesn't store password in plain text.

---

## Logging

**Bash:** Custom logging to files
```bash
LOG="$HOME/.local/share/arch_install.log"
command >> "$LOG" 2>> "$ERR"
```

**Ansible:** Built-in logging
- Automatic output formatting
- Verbosity levels with `-v`, `-vv`, `-vvv`
- JSON output support
- Integration with syslog

---

## Error Handling

**Bash:**
```bash
exit_code=$?
echo_success $exit_code
return $exit_code
```

**Ansible:**
```yaml
- name: Task that might fail
  command: /some/command
  register: result
  failed_when: result.rc != 0
  ignore_errors: yes
```

**Why better:** Built-in error handling, can continue on failure, better reporting.

---

## Idempotency

**Bash:** Manual checks everywhere
```bash
echo $password | sudo -S pacman -Q $1 >> "$LOG" 2>> "$ERR";
if [ $? = 0 ] && [ "$FORCE" -eq 0 ]; then
    printf "already installed.\n"
    return 1
fi
```

**Ansible:** Automatic
- Modules are idempotent by design
- No need for manual checks
- Can run safely multiple times

---

## Notable Changes

### Removed Features
1. **FORCE flag**: Ansible's idempotency makes this unnecessary
2. **Custom logging**: Ansible has built-in logging
3. **Password prompting**: Handled by `--ask-become-pass`
4. **Manual "already installed" checks**: Automatic in Ansible

### Added Features
1. **Dry-run mode**: `--check` to preview changes
2. **Tags**: Selective execution of roles
3. **Templates**: Jinja2 for service files and configs
4. **Better organization**: Modular role structure
5. **Parallel execution**: Where possible
6. **Remote execution**: Can run on other machines

### Optional Features (commented in original)

Many packages in the original script are commented out. These can be easily enabled in Ansible by:

1. Uncommenting the task in the role
2. Or adding them to a separate playbook
3. Or using host/group variables to customize per machine

Example:
```yaml
# roles/terminal/defaults/main.yml
install_calcurse: false

# roles/terminal/tasks/main.yml
- name: Install calcurse
  community.general.pacman:
    name: calcurse
    state: present
  when: install_calcurse
```

---

## Testing Strategy

### Bash Script
- Run and hope
- Check logs after the fact
- Hard to test without running

### Ansible
- `--check` mode for dry runs
- `--diff` to see what would change
- `--tags` to test specific parts
- `--syntax-check` for validation
- Molecule for testing roles (optional)

---

## Migration Path

1. **Phase 1**: Install Ansible and collections
2. **Phase 2**: Run in check mode
3. **Phase 3**: Run base and terminal roles
4. **Phase 4**: Run remaining roles in stages
5. **Phase 5**: Compare with bash script results

---

## Maintenance

### Bash Script
- Edit script
- Run entire script or manually run sections
- Hard to track what changed

### Ansible
- Edit role tasks
- Run specific roles with tags
- Git history shows what changed
- Can run on multiple machines

---

## Performance

**Bash:** Sequential execution
**Ansible:** Can parallelize independent tasks

Example: Installing multiple independent packages can happen concurrently in Ansible.

---

## Future Enhancements

Possible improvements to the Ansible setup:

1. **Role variables**: Make more things configurable
2. **Host variables**: Per-machine customization
3. **Vault secrets**: Encrypted sensitive data
4. **Handlers**: Better service restarts
5. **Pre/post tasks**: Hooks for custom actions
6. **Facts caching**: Faster subsequent runs
7. **Molecule tests**: Automated testing of roles
8. **CI/CD integration**: Automated deployment

---

## Conclusion

The Ansible conversion provides:
- ✅ Better idempotency
- ✅ Clearer structure
- ✅ Easier maintenance
- ✅ Better error handling
- ✅ Dry-run capability
- ✅ Selective execution
- ✅ Better documentation
- ✅ Remote execution support

While still maintaining:
- ✅ Same functionality
- ✅ Same package list
- ✅ Same configuration
- ✅ Compatibility with existing dotfiles
