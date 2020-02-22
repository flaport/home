# SSH folder

For security reasons, i won't push the hosts, nor the public keys to the `arch_home` repo.

## Hosts
Hosts can easily be configured in `~/.ssh/config` as follows:
```
    Host <name>
    Hostname <ip-address>
    User <username>
    ForwardX11 yes
    LocalForward 127.0.0.1:8888 127.0.0.1:8888
    Port 22
```

## Public-private key-pair
Create an ssh key:
```
    ssh-keygen
```
Install it on the remote server:
```
    ssh-copy-id <username>@<ip-address>
```
You can now log in without a password.

