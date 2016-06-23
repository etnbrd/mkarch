This repo contains all the scripts and confiration files to setup my machines.

`mkarch` are the scripts for the very first step to setup a basic machine.

`hosts` are the salt configurations to setup the machines after the basic install.

# mkarch

mkarch is a set of scripts I use to automate the setup of my archs.
They are pretty old and unreliable. I need to update them.

# salt

To setup a machine after the basic install.

+ Login as root

```
# install git and salt
pacman -Suy git salt-raet

# clone this repo onto your machine
git clone https://github.com/etnbrd/mkarch.git
cd mkarch

# change the configuration to setup a masterless minion
cp hosts/minion /etc/salt/
#cd /etc/salt/
#sed -i "s/#*\(file_client *: \).*/\1local/" minion

# Modify the .localrc file.
vi hosts/arch-srv/config/.localrc

# deploy credentials
cp ... hosts/arch-srv/credentials

# install the formulas in the right place
cp -r hosts/arch-srv/ /srv/salt/

# launch the salt command
salt-call --local state.highstate

```


+ Login as etn

```

# bootstrap
.dotfiles/bin/bootstrap

# verify password
sudo id

# restart sshd to remove root login
systemctl restart sshd

# exit and reconnect for changes to take effect
exit

```
