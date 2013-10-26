#!/bin/zsh
#
# mkpost.sh by etnbrd
# This script install the salted system

# The one-liner :)
# zsh <(wget https://raw.github.com/gravitezero/mkarch/master/mkpost.sh -qO -);

#####################################################
# COMMANDS                                          #
#####################################################

SOURCE="https://raw.github.com/gravitezero/mkarch/master";
HOSTNAME = `cat /etc/hostname`;

source <(wget ${SOURCE}/utils.sh -qO -);

# TODO get the complete pacman.conf
curl ${SOURCE}/hosts/$HOSTNAME/archlinuxfr.repo >> /mnt/etc/pacman.conf
# wget ${SOURCE}/hosts/$HOSTNAME/archlinuxfr.repo -qO - >> /mnt/etc/pacman.conf

chrootsh pacman -Sy --noconfirm yaourt &&
chrootsh yaourt -Sy --noconfirm salt
Error $? "$ER Failed to install yaourt and salt" "$IF yaourt and salt installed"

# TODO states should be stored in home
# TODO find another way to get states
rm -rf /srv/salt;
wget -q https://github.com/gravitezero/mkarch/archive/master.tar.gz;
quiet tar xzvf master.tar.gz;
mv mkarch-master/hosts/$HOSTNAME/salt /srv;
rm -rf master.tar.gz mkarch-master;

salt-call --local state.highstate