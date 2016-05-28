if [ hash brew 2>/dev/null ]; then
  # nottin
  echo "no brew installed"
else
  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
  fi
fi

# store local ip
DEVICE='en0'
LOCAL_HOST_IP=`ifconfig $DEVICE | grep inet | grep -v inet6 | awk '{print $2}'`
echo "Local host: $LOCAL_HOST_IP"

#This makes Ctrl-S (forward-search-history) work.
stty stop undef

export HISTSIZE=10000 #bash history will save this many commands.
export HISTFILESIZE=${HISTSIZE} #bash will remember this many commands.
export HISTCONTROL=ignoredups #ignore duplicate commands
export HISTIGNORE="ls:pwd:exit:clear" #don't put this in the history.
export HISTTIMEFORMAT="[%Y-%m-%d - %H:%M:%S] "

shopt -s cmdhist # save multi-line commands as a single line in the history.
shopt -s expand_aliases   # expand aliases in this file.
shopt -s histappend # append to the history file instead of overwriting

#enable ls colors by default
if [ `eval uname` == 'Darwin' ]; then
  alias ls="ls -pG"
  #and change some colors
  export LSCOLORS=dxfxcxdxbxegedabagacad
else
  alias ls="ls --color"
  #and change some colors
  export LS_COLORS='di=33:fi=0:ln=95:pi=5:so=5:bd=5:cd=5:or=37:mi=0:ex=31:*.rpm=90'
fi

alias lsa="ls -a"
alias md5sum='md5 -r'

#display git cheatsheet
alias git-cheats="cat ~/programming/geertweening/dotfiles/git_cheatsheet"

#display android cheatsheet
alias android-cheats="cat ~/programming/geertweening/dotfiles/android_cheatsheet"

#flush dns
alias flush-dns="dscacheutil -flushcachecd"

# start and stop postgres server
alias pg_start='pg_ctl start -D /usr/local/var/postgres -l /usr/local/log/postgres-log'
alias pg_stop='pg_ctl stop -D /usr/local/var/postgres'

#set NODE_PATH
NODE_PATH=$NODE_PATH:/usr/local/lib/node_modules

export NODE_PATH

# set /usr/local/bin so brew programs get picked before system ones
export PATH=/usr/local/bin:$PATH

#node npm-installed libaries
export PATH=/usr/local/share/npm/bin:$PATH

# add user bin
export PATH=~/bin:$PATH

#Regular Colors
txtblk='\[\e[0;30m\]' # Black
txtred='\[\e[0;31m\]' # Red
txtgrn='\[\e[0;32m\]' # Green
txtylw='\[\e[0;33m\]' # Yellow
txtblu='\[\e[0;34m\]' # Blue
txtpur='\[\e[0;35m\]' # Purple
txtcyn='\[\e[0;36m\]' # Cyan
txtwht='\[\e[0;37m\]' # White
#Bold Colors
bldblk='\[\e[1;30m\]' # Black
bldred='\[\e[1;31m\]' # Red
bldgrn='\[\e[1;32m\]' # Green
bldylw='\[\e[1;33m\]' # Yellow
bldblu='\[\e[1;34m\]' # Blue
bldpur='\[\e[1;35m\]' # Purple
bldcyn='\[\e[1;36m\]' # Cyan
bldwht='\[\e[1;37m\]' # White
#Underlined Colors
unkblk='\[\e[4;30m\]' # Black
undred='\[\e[4;31m\]' # Red
undgrn='\[\e[4;32m\]' # Green
undylw='\[\e[4;33m\]' # Yellow
undblu='\[\e[4;34m\]' # Blue
undpur='\[\e[4;35m\]' # Purple
undcyn='\[\e[4;36m\]' # Cyan
undwht='\[\e[4;37m\]' # White
#Background Colors
bakblk='\[\e[40m\]'   # Black
bakred='\[\e[41m\]'   # Red
badgrn='\[\e[42m\]'   # Green
bakylw='\[\e[43m\]'   # Yellow
bakblu='\[\e[44m\]'   # Blue
bakpur='\[\e[45m\]'   # Purple
bakcyn='\[\e[46m\]'   # Cyan
bakwht='\[\e[47m\]'   # White
txtrst='\[\e[0m\]'    # Text Reset

# grep options
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'

GIT_PS1_SHOWDIRTYSTATE=1

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1$(parse_git_dirty))/"
}

update_prompt() {
	RET=$?;

	#https://wiki.archlinux.org/index.php/Color_Bash_Prompt#Advanced_return_value_visualisation
	#Basically, prepend the prompt with a green 0 if the last command returned 0, or prepend it with a red [error code] if not.
	if [ $RET == 0 ]; then
		RET_VALUE="${txtgrn}$RET"
	else
		RET_VALUE="${bldred}$RET"
	fi

	PS1="\033]0;\h\007\n$RET_VALUE \e[0;32m[\t \w] ${txtblu}$(parse_git_branch)\e[0m \n> "
}

PROMPT_COMMAND=update_prompt
