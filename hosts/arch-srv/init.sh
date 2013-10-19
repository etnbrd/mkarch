#!/bin/zsh
#
# arch-srv/init.sh by etnbrd
# This script is a configuration file for my arch-srv

Init() {
  ASK=false
  DISK_DEVICE=/dev/vda

  ROOT_SIZE=5G
  HOME_SIZE=10G

  ROOT_FS=ext4
  HOME_FS=ext4 # if HOME_FS = false, don't erase home.

  BASE="base base-devel" # Here only the strict minimum, the rest should be in the salt configuration
  HOSTNAME="arch-srv"
  LOCALZONE="Europe/Paris"
  PWD="password"
}