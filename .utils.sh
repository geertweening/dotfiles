grepinr() {
    grep -inr "$1" *
}

grepinra() {
    grep -inr "$1" * .*
}

unrar-scene() {
    echo "unrar!"
    SOURCE=$1
    DESTIN=$2
    echo "unrar from $1 to $2"
    for f in `find $SOURCE -wholename *.r01`
    do
        echo "unpacking $f in directory: $2"
        rar e -inul -o $f "$2"
    done
}

resource() {
  source ~/.profile
}

copystrings() {
    echo "copy strings 1"
    LANG=$1
    SOURCE=$2
  
    for d in `find values-* -type d`
    do
        echo "directory $d"
        echo "what?"
        awk '{split($d,array,"-")} END{print array[1]}'
    done
}

android-web() {
    adb shell am start -a android.intent.action.VIEW $1
}

sync_movies() {
    rsync -rtvu /Users/geert/Movies/ /Volumes/Passport/Movies/
}

sync_library() {
    rsync -rtvu /Users/geert/Library/Mail/ /Volumes/Passport/Backups_Mac_13_2012/Mail/
    rsync -rtvu /Users/geert/Library/Keychains/ /Volumes/Passport/Backups_Mac_13_2012/Keychains/
}

# list of bash commands
# find /Users/geert/programming/flipboard/android/src -name "*.java" -type f -exec sed -i "" 's;authorImageURL;authorImage;g' {} \;