# boot dotfiles, this file lives in ~ and is symlinked in dotfiles
if [ -f ~/dotfiles/.bootstrap ]; then
        . ~/dotfiles/.bootstrap
else
    echo "dotfiles bootstrap missing"
fi

