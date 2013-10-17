#!/bin/bash
#
# mkpart.sh by etnbrd
# This script make the partitions

$PART_ROOT;
$PART_HOME;
$ERASE_HOME;

echo "mkfs.ext4 $PART_ROOT -L root"

if $ERASE_HOME
  echo "mkfs.ext4 $PART_HOME -L home"
fi