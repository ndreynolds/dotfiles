# .bash_profile

export PATH=$PATH:/usr/local/bin

# Make sure .bashrc gets loaded when SSHing
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
