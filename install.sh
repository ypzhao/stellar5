#!/bin/bash
CUR=$(dirname $(readlink -e $0))
SIMULATOR_DIR=$CUR/third_party/web-simulator
EXTENSIONS_DIR=$CUR/third_party/brackets/src/extensions
DEF_EXT_DIR=$EXTENSIONS_DIR/default
git submodule update --init --recursive
ln -sf $SIMULATOR_DIR/ext/brackets-extension  $DEF_EXT_DIR/web-simulator
ln -sf $SIMULATOR_DIR/pkg/web $DEF_EXT_DIR/web-simulator/web
rm -rf $EXTENSIONS_DIR/user
ln -sf $CUR/src/brackets-extensions $EXTENSIONS_DIR/user

mkdir -p $EXTENSIONS_DIR/disabled

$CUR/create_manifests.sh
if [ "$1" == "--fast" ]; then
    exit 0
fi

cd $SIMULATOR_DIR && ./configure && jake
cd $CUR
# Setup vnc server
NOVNC_DIR=third_party/noVNC
sudo apt-get install tightvncserver
mkdir -p ~/.vnc
cp $NOVNC_DIR/xstartup $NOVNC_DIR/start_emulator.sh ~/.vnc
npm install connect now http-proxy
