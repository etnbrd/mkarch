This repo contains all the scripts and confiration files to setup my machines.

`mkarch` are the scripts for the very first step to setup a basic machine.

`hosts` are the salt configurations to setup the machines after the basic install.

# mkarch

mkarch is a set of scripts I use to automate the setup of my archs.
They are pretty old and unreliable. I need to update them.

# salt

To setup a machine after the basic install.

```
# install git and salt
pacman git salt-raet

# clone this repo onto your machine
git clone https://github.com/etnbrd/mkarch.git
cd mkarch

# change the configuration to setup a masterless minion
cp hosts/minion /etc/salt/
#cd /etc/salt/
#sed -i "s/#*\(file_client *: \).*/\1local/" minion

# Modify the .localrc file.
vi .localrc

# install the formulas in the right place
cp -r hosts/arch-srv /srv/salt/

# deploy credentials
cp ... /srv/salt/credentials

# launch the salt command
salt-call --local state.apply

# bootstrap
.dotfiles/bin/bootstrap

```
