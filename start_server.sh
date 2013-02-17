#Please install tightvnc/turbovnc/vnc4server before starting noVNC server
NOVNC_DIR=third_party/noVNC
if ! ps -p `cat ~/.vnc/$(hostname):1.pid`; then
    vncserver -geometry 520x700
fi
$NOVNC_DIR/utils/launch.sh --vnc localhost:5901 &
node third_party/brackets/src/extensions/default/devices/EmulatorServer.js
