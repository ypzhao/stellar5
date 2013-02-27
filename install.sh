#!/bin/bash
CUR=$(dirname $(readlink -e $0))
SIMULATOR_DIR=$CUR/third_party/web-simulator
EXTENSIONS_DIR=$CUR/third_party/brackets/src/extensions
DEF_EXT_DIR=$EXTENSIONS_DIR/default
git submodule update --init --recursive
cd $SIMULATOR_DIR && ./configure && jake
ln -sf $SIMULATOR_DIR/ext/brackets-extension  $DEF_EXT_DIR/web-simulator
ln -sf $SIMULATOR_DIR/pkg/web $DEF_EXT_DIR/web-simulator/web
rm -rf $EXTENSIONS_DIR/user
ln -sf $CUR/src/brackets-extensions $EXTENSIONS_DIR/user

mkdir -p $EXTENSIONS_DIR/disabled
function create_manifest {
    echo -n '["' > "$1"/manifest.json
    ls -m "$1" |tr -d "\n" |sed 's/, /" , "/g'>>"$1"/manifest.json
    echo -n '"]' >> "$1"/manifest.json

}

cd $CUR/third_party/brackets
for locale in samples/*; do
    for sample in $locale/*; do
        create_manifest "$sample"
    done;
done

for extension in src/extensions/*; do
    create_manifest "$extension"
done

cd $CUR
# Setup vnc server
NOVNC_DIR=third_party/noVNC
sudo apt-get install tightvncserver
mkdir -p ~/.vnc
cp $NOVNC_DIR/xstartup $NOVNC_DIR/start_emulator.sh ~/.vnc
npm install connect now http-proxy
