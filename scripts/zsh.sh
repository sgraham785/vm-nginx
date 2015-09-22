#!/usr/bin/env bash

echo 'RUNNING ZSH INSTALL....'

# Install zsh shell
yum -y install zsh

# Install oh my zsh shell
su vagrant -c 'wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh'

# Change shell for Vagrant
sudo chsh -s /bin/zsh vagrant

# Change the oh my zsh default theme. More themes here: https://github.com/robbyrussell/oh-my-zsh/wiki/themes
# sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="miloshadzic"/g' ~/.zshrc

# Initialize
su vagrant -c 'zsh'

