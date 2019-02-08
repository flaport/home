cd $HOME/.jupyter
printf "\
[Unit]\n\
Description=Jupyterhub\n\
After=syslog.target network.target\n\
\n\
[Service]\n\
User=root\n\
Environment=\"PATH="$HOME"/.anaconda/bin:/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin\"\n\
ExecStart="$HOME"/.anaconda/bin/jupyterhub -f "$HOME"/.jupyter/jupyterhub_config.py\n\
\n\
[Install]\n\
WantedBy=multi-user.target\n\
" >> jupyterhub.service
sudo cp jupyterhub.service /etc/systemd/system/jupyterhub.service
sudo systemctl enable jupyterhub
sudo systemctl start jupyterhub
