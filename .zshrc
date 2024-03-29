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
	zsh-autosuggestions
	zsh-syntax-highlighting
)

# ZSH Autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'

source $ZSH/oh-my-zsh.sh

# User configuration
setopt PROMPT_SUBST ; PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
setopt complete_aliases # don't espand aliases before completion has finished
setopt autocd		# Automatically cd into typed directory.
setopt share_history # Share history between multiple shells
# No Beep
setopt no_beep
setopt no_list_beep
setopt no_hist_beep
# Hstr
setopt histignorespace

# Load configs
for config (~/.zsh/*) source $config

bindkey -s "\C-r" "\C-a hstr -- \C-j"

eval "$(starship init zsh)"
