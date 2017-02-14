# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="avit"
#ZSH_THEME="random"
#ZSH_THEME="kafeitu"
#ZSH_THEME="candy"
#ZSH_THEME="agnoster"
ZSH_THEME="nicoulaj"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
 DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
 export UPDATE_ZSH_DAYS=7

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
 HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(bower command-not-found common-aliases compleat copydir copyfile cp encode64 fasd git github gitignore git-extras gulp last-working-dir lol node pj ssh-agent thefuck vi-mode wd web-search yarn zsh-autosuggestions zsh-nvm)

# User configuration

# export MANPATH ="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh
source $HOME/.dotfiles/.env
source $HOME/.dotfiles/.dbconfig.sh

# Runs terminal at startup
#[[ $TERM != "screen" ]] && exec tmux

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# SSH configurations
# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Enables shortcut to ssh-add
zstyle :omz:plugins:ssh-agent agent-forwarding on

# Quick Navigation

# This uses the plugin 'pj'. Can now open project folder by entering 'pj project-title'
PROJECT_PATHS=(~/projects)
# 'pjo project-title' will open project in $EDITOR

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# alias ohmyzsh="mate ~/.oh-my-zsh"
#source .aliases/source
source $HOME/.dotfiles/.aliases.sh


#export PATH="$HOME/.linuxbrew/bin:$PATH"
#export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
#export INFOPATH="$HOME/.linuxbrew/share/inofo:$INFOPATH"
#export PATH=$PATH:#/.composer/vendor/bin
#export PATH=$PATH:/usr/local/bin/
#export PATH=$PATH:/usr/bin

autoload -U +X bashcompinit && bashcompinit
source ~/wp-completion.bash

###-begin-pm2-completion-###
### credits to npm for the completion file model
#
# Installation: pm2 completion >> ~/.bashrc  (or ~/.zshrc)
#

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

if type complete &>/dev/null; then
  _pm2_completion () {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           pm2 completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -o default -F _pm2_completion pm2
elif type compctl &>/dev/null; then
  _pm2_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       pm2 completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _pm2_completion + -f + pm2
fi
###-end-pm2-completion-###

###-load-nvmrc-if-exists-###
autoload -U add-zsh-hook
load-nvmrc() {
    if [[ -f .nvmrc && -r .nvmrc  ]]; then
        nvm use
    elif [[ $(nvm version) != $(nvm version default)   ]]; then
        echo "Reverting to nvm default version"
        nvm use default
    fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
###-end-load-nvmrc-if-exists-###

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
