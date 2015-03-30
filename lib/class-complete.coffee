module.exports =
    activate: ->
        atom.workspaceView.command "class-complete:complete", => @complete()

    complete: ->
        editor = atom.workspace.getActivePaneItem()
        cursor = editor.getCursor()
        text = cursor.getCurrentBufferLine().trim()
        splitText = text.split(":")
        className = splitText[0]
        parameters = splitText[1].split(",")

        editor.selectToBeginningOfLine()
        editor.insertText(className + " = (function() {\n")
        editor.insertText("\tfunction " + className + "(")
        `for(var i = 0; i < parameters.length; i++) {
            if(i == parameters.length - 1) editor.insertText(parameters[i]);
            else editor.insertText(parameters[i] + ", ");
        }`
        editor.insertText(") {\n")
        editor.insertText("\t\n")
        editor.insertText("\t}\n")
        editor.insertText("\n")
        editor.insertText("\treturn " + className + ";")
        editor.insertText("\n}());")
