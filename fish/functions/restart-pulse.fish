function restart-pulse --description "Force pulseaudio to restart"
    pulseaudio -k
    pulseaudio -D --log-target=syslog
end
