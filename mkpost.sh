#!/bin/sh
#
# mkpost.sh by etnbrd
# This script install the salted system

# The one-liner :)
# zsh <(curl -s https://raw.github.com/gravitezero/mkarch/master/mkpost.sh);
# curl -s https://raw.github.com/gravitezero/mkarch/master/mkpost.sh | sh

#####################################################
# COMMANDS                                          #
#####################################################

SOURCE="https://raw.github.com/gravitezero/mkarch/master";
HOSTNAME=`cat /etc/hostname`;

# curl -s ${SOURCE}/utils.sh | source /dev/stdin;
source <(curl -s ${SOURCE}/utils.sh);

# TODO get the complete pacman.conf
curl -s ${SOURCE}/hosts/$HOSTNAME/archlinuxfr.repo >> /etc/pacman.conf
# wget ${SOURCE}/hosts/$HOSTNAME/archlinuxfr.repo -qO - >> /mnt/etc/pacman.conf

pacman -Sy --noconfirm yaourt &&
yaourt -Sy --noconfirm salt
Error $? "$ER Failed to install yaourt and salt" "$IF yaourt and salt installed"

# TODO states should be stored in home
# TODO find another way to get states
rm -rf /srv/salt;
curl -s -o master.tar.gz https://github.com/gravitezero/mkarch/archive/master.tar.gz;
tar xzf master.tar.gz;
mv mkarch-master/hosts/$HOSTNAME/salt /srv;
rm -rf master.tar.gz mkarch-master;

salt-call --local state.highstate