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



