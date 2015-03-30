module.exports =
    activate: ->
        atom.workspaceView.command "class-complete:complete", => @complete()

    complete: ->
        editor = atom.workspace.getActivePaneItem()
        cursor = editor.getCursor()
        text = cursor.getCurrentBufferLine().trim()
        splitText = text.split(":")
        className = splitText[0]
        parameters = []

        editor.selectToBeginningOfLine()
        editor.insertText(className + " = (function() {\n")
        editor.insertText("\tfunction " + className + "(")
        if splitText.length > 1
            editor.insertText(splitText[1])
        editor.insertText(") {\n")
        editor.insertText("\t\n")
        editor.insertText("\t}\n")
        editor.insertText("\n")
        editor.insertText("\treturn " + className + ";")
        editor.insertText("\n}());")
