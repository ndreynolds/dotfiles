# .bash_profile

export PATH=/usr/local/bin:$PATH

# Make sure .bashrc gets loaded when SSHing
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
