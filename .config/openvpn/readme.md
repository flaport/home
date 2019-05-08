# OpenVPN folder

## OpenVPN profile

place an openvpn profile named `profile.ovpn` in this folder

## OpenVPN certificate

place your openvpn certificates also in this folder

## OpenVPN service

a sample openvpn systemd service `openvpn.service` was added as example to this folder.
If you followed the full installation instructions, this service will be automatically 
installed into systemd services. You can also manually edit the service to your liking
(be sure to replace `{home}` with the actual (full) location of your home folder).
