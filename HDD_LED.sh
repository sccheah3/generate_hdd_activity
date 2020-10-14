#! /bin/bash

####################################################################
# Script Name    :HDD_LED.sh
# Description    :Generates disk activity on all drives to test LEDS
# Args           :verbose option
# Author         :Stanley Cheah
# Email          :StanleyCheah@supermicro.com
####################################################################

# check for verbose flag
if [[ "$1" == -v ]] ; then
  echo_verbose="echo"
else
  echo_verbose=":"
fi

# save all disk names
diskname_sd=/dev/sd*
diskname_nvme=/dev/nvme*

# generate disk activity on drives in system
generate_disk_activity() {
  if [[ -e "$1" ]] ; then
    # "$echo_verbose" "---------------------------------------------"
    "$echo_verbose" "Generating activity on DISK: $1"    
    dd if="$1" of=/dev/null bs=1M count=200 &> /dev/null
  fi
}

# iterate through all disks that start with /dev/sd
for disk in $diskname_sd ; do
  generate_disk_activity "$disk" 
done

# iterate through all NVMes
for disk in $diskname_nvme ; do
  generate_disk_activity "$disk"
done
