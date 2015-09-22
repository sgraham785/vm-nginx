# Cleanup
#
sudo yum -y clean all

set -x
# Make sure Udev doesn't block our network
# http://6.ptmc.org/?p=164
echo "cleaning up udev rules"
# sudo rm /etc/udev/rules.d/70-persistent-net.rules
sudo mkdir /etc/udev/rules.d/70-persistent-net.rules
sudo rm -rf /dev/.udev/
# sudo rm /lib/udev/rules.d/75-persistent-net-generator.rules

# Remove log files from the VM
find /var/log -type f -exec rm -f {} \;

# Remove locale seed
sudo rm -f /root/locale-preseed.cfg


# Only on non-vagrant hosts
if [ ! -f /home/vagrant/.vbox_version ] ; then
    # Remove system ssh-keys so that each machine is unique
    sudo rm -f /etc/ssh/*key*
fi

# cleanup
if [ -f /etc/debian_version ] ; then
    # Removing leftover leases and persistent rules
    echo "cleaning up dhcp leases"
    sudo rm /var/lib/dhcp3/*

    # remove annoying resolvconf package
    DEBIAN_FRONTEND=noninteractive apt-get -y remove resolvconf

    echo "Adding a 3 sec delay to the interface up, to make the dhclient and cloud-init happy"
    echo "pre-up sleep 5" >> /etc/network/interfaces
    # Remove all kernels except the current version
    dpkg-query -l 'linux-image-[0-9]*' | grep ^ii | awk '{print $2}' | \
        grep -v $(uname -r) | xargs -r apt-get -y remove
    apt-get -y clean all
elif [ -f /etc/redhat-release ] ; then
    # Remove hardware specific settings from eth0
    # sed -i -e 's/^\(HWADDR\|UUID\|IPV6INIT\|NM_CONTROLLED\|MTU\).*//;/^$/d' \
        /etc/sysconfig/network-scripts/ifcfg-eth0
    # Remove all kernels except the current version
    sudo rpm -qa | grep ^kernel-[0-9].* | sort | grep -v $(uname -r) | \
        xargs -r yum -y remove
    sudo yum -y clean all
fi
# Have a sane vimrc
# echo "set background=dark" >> /etc/vimrc
#rm /tmp/common.sh

# Zero disk
#
# set -x
# Zero out the free space to save space in the final image:
sudo dd if=/dev/zero of=/EMPTY bs=1M
sync
sudo rm -f /EMPTY
sync
exit

