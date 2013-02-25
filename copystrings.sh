echo "copy strings"
SOURCE="$1"
echo $SOURCE

for d in `find $SOURCE -type f`
do
    echo "file $d"
    read -e -p "location: " location
    cp $d "$location/strings.xml"
done