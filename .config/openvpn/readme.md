# openvpn

## OpenVPN profile

place an openvpn profile named `profile.ovpn` in this folder

## OpenVPN certificate

place your openvpn certificates also in this folder

## OpenVPN service

a sample openvpn systemd service `openvpn.service` was added as example to this folder.
If you followed the full installation instructions, this service will be automatically
installed into systemd services. You can also manually edit the service to your liking
(be sure to replace `{home}` with the actual (full) location of your home folder).

## Save password

optional: save your username and password for the openvpn connection into a
seperate file `password.txt` and add the line `auth-user-pass password.txt` to your profile. Be sure to do a `chmod 600` on the file to make the file unreadable by other users.
