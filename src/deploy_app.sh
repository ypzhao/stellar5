WRT_LAUNCHER="/usr/bin/wrt-launcher"
WGT_CMD="pkgcmd -t wgt -q"
testPkg="$TEST_WIDGETS_DIR$pkgName"
namedWgtCmd="$WGT_CMD -n $projectId"

unzip -p "$tmpPkg" > t && unzip -p "$testPkg" >t1
if ! diff t t1 >/dev/null  ; then
    cp "$tmpPkg" $TEST_WIDGETS_DIR && $WRT_LAUNCHER --developer-mode 1 && $namedWgtCmd -s  && $namedWgtCmd -u;
    $WGT_CMD -i -p "$testPkg"
else 
    $WRT_LAUNCHER --kill $projectId
fi
sleep 1
$WRT_LAUNCHER --start $projectId --debug --timeout=90
