export FL_HOME=${HOME}/Programming/Flipboard/git/services

# set classpath
eval `cd ${FL_HOME}/src ; make cp`

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

if [[ -f ~/.git-completion.bash ]]; then
    . ~/.git-completion.bash
fi

if [[ -f ~/bash/android.sh ]]; then
    . ~/bash/android.sh
fi

if [[ -f ~/bash/bashperiments.sh ]]; then
    . ~/bash/bashperiments.sh
fi

if [[ -f ~/bash/utils.sh ]]; then
    . ~/bash/utils.sh
fi

PATH=/usr/local/bin:$PATH
PATH=$PATH:${HOME}/bash:/Applications/XAMPP/xamppfiles/bin
PATH=$PATH:${HOME}/Programming/Android/android-sdk-mac_x86/tools
PATH=$PATH:${HOME}/Programming/Android/android-sdk-mac_x86/platform-tools

export PATH