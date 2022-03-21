if [[ -z $DISPLAY && $(tty) == /dev/tty1 && $XDG_SESSION_TYPE == tty ]]; then
	  MOZ_ENABLE_WAYLAND=1 QT_QPA_PLATFORM=wayland XDG_SESSION_TYPE=wayland exec dbus-run-session gnome-session
fi

# Path to your oh-my-zsh installation.
export ZSH="/home/mirko/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="fino"

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

#update non-core plugins
# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=1

# ZSH Autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'

source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
export LANG=it_IT.UTF-8

setopt PROMPT_SUBST ; PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
setopt complete_aliases # don't espand aliases before completion has finished
setopt autocd		# Automatically cd into typed directory.
setopt share_history # Share history between multiple shells
# No Beep
setopt no_beep
setopt no_list_beep
setopt no_hist_beep
stty stop undef		# Disable ctrl-s to freeze terminal.

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Colored Gcc errors and warnings
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#set bat as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Custom path
export PATH=$PATH:$HOME/.local/bin:$HOME/.cargo/bin

#Default editor is doom-emacs of course
export EDITOR='vim'

# ignore this in history
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"

export MOZ_USE_XINPUT2="1"		# Mozilla smooth scrolling/touchpads.

export TERM="screen-256color"

# ======== Aliases

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias diff='diff --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias ip='ip -color=auto'
fi

# Use ripgrep instead grep wich is a lot better
alias grep="rg -p --stats -U"

#Use exa that is better than ls
alias ls="exa --group-directories-first --header"
alias ll='exa  -lbF --color=always --group-directories-first --header'
alias lla='exa -lbhHigUmuSa --time-style=long-iso --git --color-scale --header'
alias la='exa -ah --color=always --group-directories-first --header'
alias lt='exa --tree --level=3 --color=always --group-directories-first' # tree listing

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

# Reload config
alias reload!='. ~/.zshrc'

# git aliases
alias gp="git push"
alias gs="git status -sb"
alias gc="git commit"
alias gcm="git commit -m"
alias ga="git add"
alias gaa="git add -A"
alias git-versiontree="git log --graph --pretty=format:'%C(auto) %h | %s | %an | %ar%d'"
alias git-fco="git commit --fixup"

# ps
alias psa="ps auxf | less"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4 | less'
alias pscpu='ps auxf | sort -nr -k 3 | less'

# HSTR configuration
alias hh=hstr                    # hh to be alias for hstr
setopt histignorespace           # skip cmds w/ leading space from history
export HSTR_CONFIG=hicolor,case-sensitive       # get more colors with case-sensitive search
bindkey -s "\C-r" "\C-a hstr -- \C-j"     # bind hstr to Ctrl-r (for Vi mode check doc)

eval "$(starship init zsh)"

function mc (){
	#create dir and cd into it
	mkdir -p "$@" && cd "$@"
}

