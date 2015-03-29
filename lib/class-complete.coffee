module.exports =
    activate: ->
        atom.workspaceView.command "class-complete:complete", => @complete()

    complete: ->
        editor = atom.workspace.activePaneItem
        editor.insertText("
            Class = (function() {\n
                \tfunction Class() {\n
                \t\n
                \t}\n
                \n
                \treturn Class;\n
            }());")
