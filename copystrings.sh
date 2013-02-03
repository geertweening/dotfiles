echo "copy strings 1"
LANG=$1
SOURCE=$2

echo $LANG

for d in `find $LANG values-* -type d -maxdepth 1`
do
    echo "directory $d"
    echo "what?"
    var=$d
    echo ${var%-*}
    lang=${var#*-}
    echo $lang
    path=`pwd`
    path=$path/values-$lang
    echo $path
    for r in `find $SOURCE strings_$lang.xml -type f -maxdepth 1`
    do
        echo "r$r"
    done
done