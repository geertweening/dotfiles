# Arthur style prompt
# export PS1="\033]0;\h\007\n\e[0;32m[\t \u@\h \w]\e[0m\n> "

# if [ hash brew 2>&- && -f `brew --prefix`/etc/bash_completion ]; then
if [ hash brew 2>/dev/null ]; then
  # nottin
  echo "no brew installed"
else
  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
  fi
fi

# store local ip
LOCAL_HOST_IP=`ifconfig en1 | grep inet | grep -v inet6 | awk '{print $2}'`

#This makes Ctrl-S (forward-search-history) work.
stty stop undef

export HISTSIZE=100000 #bash history will save this many commands.
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
alias love="~/Programming/Love2D/love.app/Contents/MacOs/love"
alias md5sum='md5 -r'

#display git cheatsheet
alias git-cheats="cat ~/dotfiles/git_cheatsheet"

#display android cheatsheet
alias android-cheats="cat ~/dotfiles/android_cheatsheet"

#flush dns
alias flush-dns="dscacheutil -flushcachecd"

# program aliases
alias eclipse="open -a Eclipse\ Java"
alias sublime="open -a Sublime\ Text\ 2"

if [ -f ~/todo-txt/todo.sh ]; then
  # todo.txt
  PATH=$PATH:"~/todo-txt/"
  alias todo='~/todo-txt/todo.sh -d ~/todo-txt/todo.cfg'
  source ~/todo-txt/todo_completion
  complete -F _todo todo
  export TODOTXT_DEFAULT_ACTION=ls
fi

#set NODE_PATH
NODE_PATH=$NODE_PATH:/usr/local/lib/node_modules

export NODE_PATH

#set pytyon scripts
export PATH=/usr/local/share/python:$PATH

#set android sdk tools and platform tools
export PATH=/Users/geert/programming/android/sdk/tools:$PATH
export PATH=/Users/geert/programming/android/sdk/platform-tools:$PATH

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

#Thanks Gary Bernhardt.
minutes_since_last_commit() {
	now=`date +%s`
	last_commit=`git log --pretty=format:'%at' -1`
	seconds_since_last_commit=$((now - last_commit))
	minutes_since_last_commit=$((seconds_since_last_commit / 60))
	echo $minutes_since_last_commit
}

# Revision of the svn repo in the current directory
svn_rev() {
	unset SVN_REV
	local rev=`svn info 2>/dev/null | grep -i "Revision" | cut -d ' ' -f 2`
	if test $rev
		then
			SVN_REV=" ${bldgrn}svn:${txtrst}$rev"
	fi
}

git_prompt() {
	if [[ -f ~/.git-completion.bash ]]; then
		local g="$(__gitdir)"
		if [ -n "$g" ]; then
			local MINUTES_SINCE_LAST_COMMIT=`minutes_since_last_commit`
			if [ "$MINUTES_SINCE_LAST_COMMIT" -gt 30 ]; then
				local COLOR=${bldred}
			elif [ "$MINUTES_SINCE_LAST_COMMIT" -gt 10 ]; then
				local COLOR=${bldylw}
			else
				local COLOR=${bldgrn}
			fi
			local SINCE_LAST_COMMIT="${COLOR}$(minutes_since_last_commit)m${bldgrn}"
			# __git_ps1 is from the Git source tree's contrib/completion/git-completion.bash
			local GIT_PROMPT=`__git_ps1 "(%s|${SINCE_LAST_COMMIT})"`
			echo ${GIT_PROMPT}
		fi
	fi
}

GIT_PS1_SHOWDIRTYSTATE=1

update_prompt() {
	RET=$?;

	#https://wiki.archlinux.org/index.php/Color_Bash_Prompt#Advanced_return_value_visualisation
	#Basically, prepend the prompt with a green 0 if the last command returned 0, or prepend it with a red [error code] if not.
	RET_VALUE="$(if [[ $RET == 0 ]]; then echo -ne "${bldgrn}$RET"; else echo -ne "${bldred}$RET"; fi;)"
	
	#call svn_rev
	svn_rev

	if [[ `eval whoami` == 'geertweening' ]]; then
	  if [[ `eval hostname` == 'Geert.local' ]]; then
		  PS1="${txtgrn}[\t \w${txtgrn}]"
	  else 
      PS1="${txtred}[\t \w${txtred}]"
    fi
	else 
		PS1="${txtblu}[\t \u \w${txtblu}]"
	fi
	PS1="$PS1 ${bldgrn}$(git_prompt)${SVN_REV}"

	#http://www.fileformat.info/info/unicode/char/26a1/index.htm
	PS1="$PS1${txtgrn}"

	# Set the title to user@host: dir
	PS1="\[\e]0;\u@\h: \w\a\]$PS1"
	
	#append return value of last command
	#PS1="\033]0;\h\007\n\e$RET_VALUE $PS1${txtrst}\n> "
	PS1="\033]0;\h\007\n\e$RET_VALUE $PS1${txtrst}\n> "

	
	#PS1="\033]0;\h\007\n\e[0;32m[\t \u@\h \w]\e[0m\n> "

}

PROMPT_COMMAND=update_prompt