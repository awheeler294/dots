local DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
if [[ -e "$HOME"/homebrew ]]; then 
   eval "$($HOME/homebrew/bin/brew shellenv)"
   export HOMEBREW_BUNDLE_FILE=$HOME/.config/Brewfile
fi

# Download Znap, if it's not there yet.
[[ -f "$HOME"/.config/zsh/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git .config/zsh/zsh-snap

source "$HOME"/.config/zsh/zsh-snap/znap.zsh  # Start Znap

# `znap source` automatically downloads and starts your plugins.
# znap source 'marlonrichert/zsh-autocomplete'
znap source 'zsh-users/zsh-autosuggestions'
znap source 'zsh-users/zsh-history-substring-search'
znap source 'zsh-users/zsh-syntax-highlighting'

# Print some system information when the shell is first started
# Print a greeting message when shell is started
echo $USER@$HOST  $(uname -srm)

# `znap prompt` makes your prompt visible in just 15-40ms!
# export SPACESHIP_CONFIG_FILE="$HOME/.config/spaceship/spaceship.zsh"
# znap prompt "spaceship-prompt/spaceship-prompt"

## Options section
setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
#HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=500
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word


## Keybindings section
# bindkey -v                                        # vi mode
bindkey '^[[7~' beginning-of-line                 # Home key
bindkey '^[[H' beginning-of-line                  # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line  # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                       # End key
bindkey '^[[F' end-of-line                        # End key
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line         # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                    # Insert key
bindkey '^[[3~' delete-char                       # Delete key
bindkey '^[[C'  forward-char                      # Right key
bindkey '^[[D'  backward-char                     # Left key
bindkey '^[[5~' history-beginning-search-backward # Page up key
bindkey '^[[6~' history-beginning-search-forward  # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                       #
bindkey '^[Od' backward-word                      #
bindkey '^[[1;5D' backward-word                   #
bindkey '^[[1;5C' forward-word                    #
bindkey '^H' backward-kill-word                   # delete previous word with ctrl+backspace
bindkey '^[[Z' undo                               # Shift+tab undo last action

aliases_file="$HOME/.config/extend-rc/aliases"
if [ -f "$aliases_file" ]; then
   # echo "sourcing aliases from $aliases_file"
   # cat "$aliases_file"

    . "$aliases_file"
else
   ## Alias section 
   alias cp="cp -i"                                  # Confirm before overwriting something
   alias df='df -h'                                  # Human-readable sizes
   alias free='free -m'                              # Show sizes in MB
   alias gitu='git add . && git commit && git push'
   alias ll='grc ls -lha'
   alias slog='grc sudo tail -f /var/log/syslog'
   alias vim='nvim'
   #alias tmux="tmux -2"
   #alias tmux="TERM=screen-256color-bce tmux"
   #alias tmux="TERM=xterm-256color tmux"
   #alias tmux="TERM=tmux-256color tmux"
   #alias ssh='TERM=xterm-color ssh'                  # Force xterm-color on ssh sessions
fi

env_file="$HOME/.config/extend-rc/env"
if [ -f "$env_file" ]; then
   # echo "sourcing env from $env_file"
   # cat "$env_file"

    . "$env_file"
fi
# Theming section  
autoload -U compinit colors zcalc
compinit -d
colors

# enable substitution for prompt
setopt prompt_subst

function hostname_if_ssh() {
   if [[ -n $SSH_CONNECTION ]]; then
      #echo "%{$fg[magenta]%}%n%{$reset_color%}@%{$fg[blue]%}%m "
      echo "%{$fg[blue]%}%m "
   fi
}

## Prompt (on left side) similar to default bash prompt, or redhat zsh prompt with colors
# #PROMPT="%(!.%{$fg[red]%}[%n@%m %1~]%{$reset_color%}# .%{$fg[green]%}[%n@%m %1~]%{$reset_color%}$ "

# Print some system information when the shell is first started
# Print a greeting message when shell is started
# echo $USER@$HOST  $(uname -srm)

### Prompt on right side:
##  - shows status of git when in git repository (code adapted from https://techanic.net/2012/12/30/my_git_prompt_for_zsh.html)
##  - shows exit status of previous command (if previous command finished with an error)
##  - is invisible, if neither is the case

# Modify the colors and symbols in these variables as desired.
GIT_PROMPT_SYMBOL="%{$fg[blue]%}±"                              # plus/minus     - clean repo
GIT_PROMPT_PREFIX="%{$fg[green]%}[%{$reset_color%}"
GIT_PROMPT_SUFFIX="%{$fg[green]%}]%{$reset_color%}"
GIT_PROMPT_AHEAD="%{$fg[red]%}ANUM%{$reset_color%}"             # A"NUM"         - ahead by "NUM" commits
GIT_PROMPT_BEHIND="%{$fg[cyan]%}BNUM%{$reset_color%}"           # B"NUM"         - behind by "NUM" commits
GIT_PROMPT_MERGING="%{$fg_bold[magenta]%}⚡︎%{$reset_color%}"     # lightning bolt - merge conflict
GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●%{$reset_color%}"       # red circle     - untracked files
GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}●%{$reset_color%}"     # yellow circle  - tracked files modified
GIT_PROMPT_STAGED="%{$fg_bold[green]%}●%{$reset_color%}"        # green circle   - staged changes present = ready for "git push"

parse_git_branch() {
  # Show Git branch/tag, or name-rev if on detached head
  ( git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD ) 2> /dev/null
}

parse_git_state() {
  # Show different symbols as appropriate for various Git repository states
  # Compose this value via multiple conditional appends.
  local GIT_STATE=""
  local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_AHEAD" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
  fi
  local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_BEHIND" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
  fi
  local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
  if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
  fi
  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_UNTRACKED
  fi
  if ! git diff --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MODIFIED
  fi
  if ! git diff --cached --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_STAGED
  fi
  if [[ -n $GIT_STATE ]]; then
    echo "$GIT_PROMPT_PREFIX$GIT_STATE$GIT_PROMPT_SUFFIX"
  fi
}

git_prompt_string() {
  local git_where="$(parse_git_branch)"
  
  # If inside a Git repository, print its branch and state
  [ -n "$git_where" ] && echo "$GIT_PROMPT_SYMBOL$(parse_git_state)$GIT_PROMPT_PREFIX%{$fg[yellow]%}${git_where#(refs/heads/|tags/)}$GIT_PROMPT_SUFFIX"
  
  # If not inside the Git repo, print exit codes of last command (only if it failed)
  [ ! -n "$git_where" ] && echo "%{$fg[red]%} %(?..[%?])"
}

# Right prompt with exit status of previous command if not successful
 #RPROMPT="%{$fg[red]%} %(?..[%?])" 
# Right prompt with exit status of previous command marked with ✓ or ✗
 #RPROMPT="%(?.%{$fg[green]%}✓ %{$reset_color%}.%{$fg[red]%}✗ %{$reset_color%})"

# Show vi mode in prompt
function zle-line-init zle-keymap-select {
   VIM_PROMPT="%{$bg[blue]%}%{$fg[black]%} Normal %{$reset_color%} "
   # RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}$(git_prompt_string) $EPS1"
   RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
   zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r

# Use autosuggestion
#load_plugin zsh-autosuggestions/zsh-autosuggestions.zsh 
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# HSTR configuration - add this to ~/.zshrc
alias hh=hstr                             # hh to be alias for hstr
export HISTFILE="$DATA_HOME"/.zsh_history # ensure history file visibility
[[ -e "$HISTFILE" ]] || touch "$HISTFILE"
export HSTR_CONFIG=hicolor                # get more colors

export PATH="$HOME/bin:$HOME/.cargo/bin:$PATH"
VISUAL=nvim; export VISUAL EDITOR=nvim; export EDITOR

if command -v starship >/dev/null 2>&1; then
   export STARSHIP_CACHE="$DATA_HOME"/starship/cache
   eval "$(starship init zsh)"
else
   echo " --- starship command not found, using fallback prompt --- "
   # Maia prompt
   PROMPT="$(hostname_if_ssh)%B%{$fg[cyan]%}%(4~|%-1~/.../%2~|%~)%u%b >%{$fg[green]%}>%B%(?.%{$fg[green]%}.%{$fg[red]%})>%{$reset_color%}%b " 
   RPROMPT='$(git_prompt_string)'
fi
