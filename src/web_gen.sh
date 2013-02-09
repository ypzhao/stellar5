if test -e HelloTizen; then
    rm -r HelloTizen
fi
web-gen -n "$1"
cp HelloTizen/config.xml HelloTizen/icon.png . && rm -r HelloTizen
if test -f index.html; then
    INDEX=index.html
elif test -f $1.html; then
    INDEX=$1.html
else
    FILES=(*.html)
    INDEX=${FILES[0]}
fi
sed -i "s/HelloTizen/$1/" config.xml
sed -i "s/index.html/$INDEX/" config.xml
