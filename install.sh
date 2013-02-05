#!/bin/sh
CUR=$(dirname $(readlink -e $0))
SIMULATOR_DIR=$CUR/third_party/web-simulator
git submodule update --init --recursive
cd $SIMULATOR_DIR && sudo -E ./configure && jake 
ln -sf $SIMULATOR_DIR/ext/brackets-extension  $CUR/third_party/brackets/src/extensions/default/web-simulator
ln -sf $SIMULATOR_DIR/pkg/web $CUR/third_party/brackets/src/extensions/default/web-simulator/web

cd $CUR
# Setup vnc server
NOVNC_DIR=third_party/noVNC
sudo apt-get install tightvncserver
mkdir -p ~/.vnc
cp $NOVNC_DIR/xstartup $NOVNC_DIR/start_emulator.sh ~/.vnc
