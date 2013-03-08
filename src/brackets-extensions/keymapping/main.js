/*
 * The MIT License (MIT)
 * Copyright (c) 2012 Intel Corporation. All rights reserved.
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

/*jslint vars: true, plusplus: true, devel: true, nomen: true, indent: 4, maxerr: 50, regexp: true, bitwise: true */
/*global define, brackets, $, window */

/**
 *
 */
define(function main(require, exports, module) {
    'use strict';


    var Commands        = brackets.getModule("command/Commands"),
        CommandManager = brackets.getModule("command/CommandManager"),
        Menu           = brackets.getModule("command/Menus"),
        KeyBindingManager = brackets.getModule("command/KeyBindingManager"),
        PreferencesManager      = brackets.getModule("preferences/PreferencesManager"),
        Editor = brackets.getModule("editor/Editor"),
        EditorManager = brackets.getModule("editor/EditorManager");

    brackets.getModule(["thirdparty/CodeMirror2/keymap/vim"]);
    brackets.getModule(["thirdparty/CodeMirror2/keymap/emacs"]);
    var PREFERENCES_KEY = "com.intel.stellar5.brackets-keymapping";
    CodeMirror.commands.save = function () {
        CommandManager.get(Commands.FILE_SAVE).execute();
    }

    var editMenu = Menu.getMenu(Menu.AppMenuBar.EDIT_MENU);
    var bracketsKeyMap =  null;
    editMenu.addMenuItem(Menu.DIVIDER);
    var keyMaps = ["Brackets", "Vim", "Emacs"];
    var _prefs = PreferencesManager.getPreferenceStorage(PREFERENCES_KEY, {Brackets: true});
    var _getKeyMapCommandID = function (keyMap) {
        return "edit." + keyMap + "KeyMapping";
    };
    var _setKeyMap = function (keyMap, checked) {
        var editor = EditorManager.getCurrentFullEditor()
        var cmdKeyMap = CommandManager.get(_getKeyMapCommandID(keyMap));
        var codeMirror;
        if (!editor)
            return;
        codeMirror = editor._codeMirror;
        if (checked === undefined)
            checked = !cmdKeyMap.getChecked();
        cmdKeyMap.setChecked(checked);
        _prefs.setValue(keyMap, checked);
        if (keyMap === "Brackets") { 
            codeMirror.setOption('extraKeys', checked ? Editor.codeMirrorKeyMap : null);
            KeyBindingManager.setEnabled(checked);
        }
        else{ 
            if (checked) {
                keyMaps.forEach(function (km) {
                    if (km !== "Brackets" && km != keyMap) {
                        _setKeyMap(km, false);
                    }
                })
            }
            codeMirror.setOption('keyMap', checked ? keyMap.toLowerCase() : "default");
        }
    }
    var _handleKeyMapping = function () {
        _setKeyMap(this);

    };
    keyMaps.forEach(function (keyMap) {
        var cmdKeyMap = CommandManager.register(keyMap + " Key Map",
                _getKeyMapCommandID(keyMap), _handleKeyMapping.bind(keyMap));
        editMenu.addMenuItem(cmdKeyMap.getID());
    });
    $(EditorManager).on("activeEditorChange", function () {
        keyMaps.forEach(function (keyMap) {
            if (_prefs.getValue(keyMap))
                _setKeyMap(keyMap, true);
            else if (keyMap === "Brackets")
                _setKeyMap(keyMap, false);
        });
    });
});
