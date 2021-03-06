# .bashrc

#for interactive shell only
#[ -z "$PS1" ] && return

#######################################################################
if [[ $SHELL == /bin/bash ]]; then
#======================================================================
# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# ubuntu
if [ -f /etc/bash.bashrc ]; then
    . /etc/bash.bashrc
fi

#----------------------------------------------------------------------
if [[ "`whoami`" == "root" ]]; then
  PS1='[\u@\h: \W]# '
else
  PS1='[\u@\h: \W]$ '
fi

#----------------------------------------------------------------------
# history
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
shopt -s histappend
shopt -s checkwinsize

#Make sure all terminals save history
shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
 
#Increase history size
export HISTSIZE=1000
export HISTFILESIZE=1000

#======================================================================
fi # end of if is bash

#----------------------------------------------------------------------
for pth in $HOME/bin /usr/local/bin /bin /usr/bin /sbin /usr/sbin
do
    if ! echo ":$PATH:" | /usr/bin/grep -q ":$pth:"; then
        PATH=$PATH:$pth
    fi
done

#----------------------------------------------------------------------
# User specific aliases and functions
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias vi=vim

if [[ "`uname`" == "Darwin" ]]; then
  alias ls='ls -G'
elif [[ "`uname`" == "Linux" ]]; then
  alias ls='ls --color --ignore=*.pyc '
fi

#----------------------------------------------------------------------
export EDITOR=vim

#----------------------------------------------------------------------
if [[ -d $HOME/env.d ]]; then
    for _env in $HOME/env.d/*.env; do
        source $_env
    done
fi

if [[ "$TERM" == "linux" ]]; then
    sudo loadkeys -q ~/.keymap
fi

