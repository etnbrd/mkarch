This repo contains all the scripts and confiration files to setup my machines.
mkarch are the scripts to setup a basic machine. They are pretty old, and unreliable.
hosts are the salt configuration scripts to setup the machines after the basic install.

# mkarch

mkarch is a set of scripts I use to automate the setup of my archs.

the one-liner :  
`zsh <(wget https://raw.github.com/gravitezero/mkarch/master/main.sh -qO -)`

About zsh :  
zsh is the default shell in arch, that's why I used it.
However, the scripts should be fully compatible with bash if one replace the indirect variable reference syntax in utils.sh from `${(P)2}` (zsh syntax) to `${!2}` (bash syntax)

# Salt

To setup a machine after the basic install.

```
# install git and salt
pacman git salt-raet

# clone this repo into your machine
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
cp ... /srv/pillar
cp ... /srv/salt/credentials

# launch the salt command
salt-call --local state.apply

# bootstrap
.dotfiles/bin/bootstrap

```
