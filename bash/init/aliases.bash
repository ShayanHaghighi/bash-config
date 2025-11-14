
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
# some more ls aliases
alias la='ls -a'
alias l='ls'
alias ls='eza --group-directories-last --sort=Extension -1'
alias lt='eza -T -L 5 --git-ignore'
alias ll='eza --group-directories-last -l --git --sort=modified'

alias cat='batcat'
alias catp='batcat --paging=always'

alias fkill='kill -9 $(ps aux | fzf | awk "{print $2}")'

alias fcdr='fcd -r'
alias fcdra='fcd -r -a'
alias fcda='fcd -a'

alias python=python3
alias ...='cd ../..'
alias webstorm='gtk-launch webstorm.desktop'
alias idea='/home/shayan/Apps/idea-IU-252.27397.103/bin/idea'
alias copy='xclip -selection clipboard'
alias fd="fdfind"
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

bind TAB:complete
