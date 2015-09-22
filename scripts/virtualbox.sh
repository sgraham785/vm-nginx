# Installing the virtualbox guest additions
#!/bin/bash
set -x
if [ ! -e /home/vagrant/.vbox_version ] ; then
    exit 0
fi

# VirtualBox Additions

# kernel source is needed for vbox additions
if [ -f /etc/redhat-release ] ; then
    $yum install gcc bzip2 make kernel-devel-$(uname -r)
    $yum install gcc-c++ zlib-devel openssl-devel readline-devel
    $yum erase gtk2 libXext libXfixes libXrender hicolor-icon-theme avahi \
        freetype bitstream-vera-fonts
    if [ -f /etc/init.d/virtualbox-ose-guest-utils ] ; then
        # The netboot installs the VirtualBox support (old) so we have to
        # remove it
        /etc/init.d/virtualbox-ose-guest-utils stop
        rmmod vboxguest
        $apt purge virtualbox-ose-guest-x11 virtualbox-ose-guest-dkms \
            virtualbox-ose-guest-utils
    elif [ -f /etc/init.d/virtualbox-guest-utils ] ; then
        /etc/init.d/virtualbox-guest-utils stop
        $apt purge virtualbox-guest-utils virtualbox-guest-dkms virtualbox-guest-x11
    fi
fi

# Installing the virtualbox guest additions
VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
VBOX_ISO=/home/vagrant/VBoxGuestAdditions_${VBOX_VERSION}.iso
cd /tmp

if [ ! -f $VBOX_ISO ] ; then
    wget -q http://download.virtualbox.org/virtualbox/${VBOX_VERSION}/VBoxGuestAdditions_${VBOX_VERSION}.iso \
        -O $VBOX_ISO
fi
mount -o loop $VBOX_ISO /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt

rm $VBOX_ISO

# Only on non-vagrant hosts
if [ ! -f /home/vagrant/.vbox_version ] ; then
    # Remove system ssh-keys so that each machine is unique
    rm -f /etc/ssh/*key*
fi
