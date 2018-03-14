# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=/home/epsilon/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"
# ZSH_THEME="powerlevel9k/powerlevel9k"
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

arcpath=$HOME/workspace/arc
export PATH=${arcpath}/arcanist/bin:$PATH
if [ -f ${arcpath}/arcanist/resources/shell/bash-completion ]; then
  source ${arcpath}/arcanist/resources/shell/bash-completion
fi


export IPYTHON_ENV=/home/epsilon/.virtualenvs/calm-ipython/

start_idf_container() {
	sudo docker ps -a | grep "idf" | awk '{print $1}' | uniq | sudo xargs docker stop ||:
	sudo docker ps -a | grep "idf" | awk '{print $1}' | uniq | sudo xargs docker rm ||:
	sudo docker run -dt -p 2027:2027 opscalm/idf && sleep 120 && dbm.sh seed
}

status() {
	if [[ $VIRTUAL_ENV = *"nucalm"* ]]; then
  		echo "It's nucalm env"
		$VIRTUAL_ENV/bin/supervisorctl -c /calm/conf/supervisor/supervisord.conf $1 $2 $3
	elif [[ $VIRTUAL_ENV = *"ne"* ]]; then
  		echo "It's epsilon env"
		$VIRTUAL_ENV/bin/supervisorctl -c /epsilon/conf/supervisord.conf $1 $2 $3
	else
		echo "It's vaitarna env"
		$VIRTUAL_ENV/bin/supervisorctl -c /lambda/conf/supervisord.conf $1 $2 $3
	fi
}

start_epsilon() {
	~/vitualenvs/ne/bin/supervisord -c /epsilon/conf/supervisord.conf
}

restart_epsilon() {
	~/vitualenvs/ne/bin/supervisorctl -c /epsilon/conf/supervisord.conf restart all
}

shutdown_epsilon() {
	~/vitualenvs/ne/bin/supervisorctl -c /epsilon/conf/supervisord.conf shutdown
}

status_epsilon() {
	~/vitualenvs/ne/bin/supervisorctl -c /epsilon/conf/supervisord.conf status
}

start_calm() {
	~/vitualenvs/nucalm/bin/supervisord -c /calm/conf/supervisor/supervisord.conf
}

restart_calm() {
	~/vitualenvs/nucalm/bin/supervisorctl -c /calm/conf/supervisor/supervisord.conf restart all
}

shutdown_calm() {
	~/vitualenvs/nucalm/bin/supervisorctl -c /calm/conf/supervisor/supervisord.conf shutdown
}

status_calm() {
	~/vitualenvs/nucalm/bin/supervisorctl -c /calm/conf/supervisor/supervisord.conf status
}

start_vaitarna() {
	~/vitualenvs/le/bin/python ~/vitualenvs/le/bin/vaitarna.py
}

export WORKON_HOME=~/vitualenvs
source /usr/bin/virtualenvwrapper.sh

# GO STUFF
export GOROOT=/usr/local/go
export GOPATH=${HOME}/.go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOROOT/bin:$GOBIN:$GOPATH
export PATH=$PATH:/usr/pgsql-9.6/bin/

export PATH=$PATH:/calm/bin/
export ERGON_COMPONENT_NAME="Calm-Engine-Hercules-Shriyansh"
export DISABLE_SSL_ROUTE=true
export DISABLE_ELASTIC=true
export DEPLOYMENT_TYPE=dev

sudo ntpdate pool.ntp.org

workon nucalm
