# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# set PATH so it includes user's private bin if it exists.
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# add node to PATH if present. 
if [ -d "$HOME/local/node" ] ; then
    export PATH=$HOME/local/node/bin:$PATH
    export NODE_PATH=$HOME/local/node:$HOME/local/node/lib/node_modules
fi

# add dotfiles/bin (to end so we don't override anything important)
export PATH=$PATH:$HOME/dotfiles/bin
