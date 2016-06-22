# Installation steps for arch-pi

## salt
pacman -S salt-raet

change file_client: local for masterless in /etc/salt/minion

sudo ln -s /home/etn/arch-pi/formulas /srv/salt

sudo salt-call --local state.highstate