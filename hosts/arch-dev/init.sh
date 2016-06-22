#!/bin/zsh
#
# arch-srv/init.sh by etnbrd
# This script is a configuration file for my arch-srv

Init() {
  ASK=false
  DISK_DEVICE=/dev/vda

  ROOT_SIZE=5G
  HOME_SIZE=10G

  ROOT_FS=btrfs
  HOME_FS=btrfs # if HOME_FS = false, don't erase home.

  arch=i686

  BASE="base base-devel" # Here only the strict minimum, the rest should be in the salt configuration
  HOSTNAME="arch-dev"
  LOCALZONE="Europe/Paris"
  PWD="password"
}