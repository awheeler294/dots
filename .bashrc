# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

PROMPT=""
add_info_to_prompt()
{
   local BRANCH=""
   if git branch &>/dev/null; then
      local BRANCH_NAME=""
      BRANCH_NAME=$(git branch 2>/dev/null | grep \* |  cut -d " " -f 2)
      [[ -z $BRANCH_NAME ]] && BRANCH_NAME="master"
      BRANCH="[$BRANCH_NAME] "
    
      BRANCH="\[\033[38;5;107m\]$BRANCH\[$(tput sgr0)\]"
      BRANCH="$BRANCH\n"
   fi

   local VENV=""
   if [ -z "$VIRTUAL_ENV_DISABLE_PROMPT" ] ; then
      _OLD_VIRTUAL_PS1="$PS1"
      if [ "x" != x ] ; then
         PS1="$PS1"
      else
         if [ "`basename \"$VIRTUAL_ENV\"`" = "__" ] ; then
            # special case for Aspen magic directories
            # see http://www.zetadev.com/software/aspen/
            VENV="[`basename \`dirname \"$VIRTUAL_ENV\"\``] "
         elif [ "$VIRTUAL_ENV" != "" ]; then
            VENV="(`basename \"$VIRTUAL_ENV\"`) "
         fi
      fi
   fi

   PS1="$BRANCH$VENV$PROMPT"
}

# write to history on every command
# add python virtual environment
# get current git branch
PROMPT_COMMAND='history -a;history -n;add_info_to_prompt'

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

rightprompt()
{
    printf "%*s\n" $COLUMNS $1
}

if [ "$color_prompt" = yes ]; then
    #PROMPT='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]: \[\033[01;34m\]\w\[\033[00m\] \$ '
    PROMPT='${debian_chroot:+($debian_chroot)}\[\033[38;5;172m\]\u@\h:\[$(tput sgr0)\] \[\033[38;5;67m\]\w\[$(tput sgr0)\]\[$(tput sgr0)\[$(tput sgr0)\] \[\033[38;5;172m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]'
else
    PROMPT='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PROMPT"
    ;;
*)
    ;;
esac

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

# some more ls aliases
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

PS1=$PROMPT

fhistory() {
   cat ~/.bash_history | grep $1
}

export PATH="$HOME/bin:$PATH"
