module.exports =
    activate: ->
        atom.workspaceView.command "class-complete:complete", => @complete()

    complete: ->
        editor = atom.workspace.activePaneItem
        className = editor.getWordUnderCursor()
        editor.insertText(" = (function() {\n
                \tfunction " + className + "() {\n
                \t\n
                \t}\n
                \n
                \treturn " + className + ";\n}());")
