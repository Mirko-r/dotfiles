#  _____    _
# |__  /___| |__  _ __ ___
#   / // __| '_ \| '__/ __|
#  / /_\__ \ | | | | | (__
# /____|___/_| |_|_|  \___|

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

$HOME/.scripts/pacman.sh

# Path to your oh-my-zsh installation.
export ZSH="/home/mirko/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="dracula"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':completion:*' file-sort modification # sort file on tab completion

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
)
# ZSH Autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'

source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
export LANG=it_IT.UTF-8

setopt PROMPT_SUBST ; PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
setopt complete_aliases # don't espand aliases before completion has finished
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.

# Compilation flags
export ARCHFLAGS="-arch x86_64"

export OPENCV_LOG_LEVEL=ERROR

# Colored Gcc errors and warnings
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#set bat as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Custom path
export PATH=$PATH:$HOME/.local/bin:$HOME/.cargo/bin

#Default editor is vim of course
export EDITOR='vim'

# Aliases

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias diff='diff --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias ip='ip -color=auto'
fi

# Use ripgrep instead grep wich is a lot better
alias grep="rg -p"

#Use exa that is better than ls
alias ls="exa --icons --group-directories-first"

# some more ls aliases
alias ll='ls  -alF'
alias la='ls -a'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Make cat better with bat
alias cat="bat"

# Open any file using its default program
alias open="xdg-open"

# Confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# adding flags
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB 

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Zsh config
alias zshconfig="vim ~/.zshrc"

# Alacritty config
alias alacrittyconfig="vim $HOME/.config/alacritty/alacritty.yml"

# Vim config
alias vimconfig="vim /etc/vimrc"

# Reload config
alias reload!='. ~/.zshrc'

# git aliases
alias gp="git push"
alias gs="git status -sb"

eval "$(starship init zsh)"

function mc (){
	#create dir and cd into it
	mkdir -p "$@" && cd "$@"
}
