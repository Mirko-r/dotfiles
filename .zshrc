# Path to your oh-my-zsh installation.
export ZSH="/home/mirko/.oh-my-zsh"

## EXPORTS

export MOZ_USE_XINPUT2=1
export MOZ_ENABLE_WAYLAND=1

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

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Colored Gcc errors and warnings
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#set bat as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Custom path
export PATH=$PATH:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.local/share/gem/ruby/3.0.0/bin:~/.emacs.d/bin

#Default editor is doom-emacs of course
export EDITOR='vim'

# ignore this in history
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"

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
alias ls="exa --icons --group-directories-first --header"
alias ll='exa  -lbF --icons --color=always --group-directories-first --header'
alias lla='exa -lbhHigUmuSa --icons --time-style=long-iso --git --color-scale --header'
alias la='exa -ah --icons --color=always --group-directories-first --header'
alias lt='exa --tree --level=3 --icons --color=always --group-directories-first; echo -e "\nFile totali: $(find ./ -type f | wc -l)"' # tree listing

# Make cat better with bat
alias cat="bat"

# Confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# Memory / disk management
alias df='df -h'                          					# human-readable sizes
alias free='free -m'                      					# show sizes in MB
alias disks='lsblk -o NAME,SIZE,TYPE,MOUNTPOINTS,FSTYPE'			# show disk and fs

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Zsh config
alias zshconfig="vim ~/.zshrc"

# Reload config
alias reload!='. ~/.zshrc'

# git aliases
alias gp="git push"
alias gs="git status -sb"
alias gcm="git commit -m"
alias gaa="git add -A"
alias gacm="git add -A; git commit -m"
alias gl="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"
alias git-versiontree="git log --graph --pretty=format:'%C(auto) %h | %s | %an | %ar%d'"
alias git-fco="git commit --fixup"

# ps
alias psa="ps auxf | less"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4 | less'
alias pscpu='ps auxf | sort -nr -k 3 | less'

#Net 
alias iip="curl --max-time 10 -w '\n' http://ident.me"
alias ping="gping"

#Pacman
alias broswe-pkgs="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"

eval "$(starship init zsh)"
eval $(thefuck --alias)
