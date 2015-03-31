module.exports =
    activate: ->
        atom.workspaceView.command "class-complete:complete", => @complete()

    complete: ->
        editor = atom.workspace.getActivePaneItem()
        cursor = editor.getCursor()
        text = cursor.getCurrentBufferLine().trim()
        splitText = text.split(":")
        className = splitText[0]

        parameters = null;
        `if(typeof splitText[1] != "undefined") {
            parameters = splitText[1].split(",")
        }`

        shouldProto = false
        `if(typeof splitText[2] != "undefined") {
            shouldProto = true
        }`

        editor.selectToBeginningOfLine()
        editor.insertText(className + " = (function() {\n")

        editor.insertText("\tfunction " + className + "(")

        `if(parameters != null) {
            for(var i = 0; i < parameters.length; i++) {
                if(i == parameters.length - 1) editor.insertText(parameters[i]);
                else editor.insertText(parameters[i] + ", ");
            }
        }`


        editor.insertText(") {\n")
        `if(shouldProto) {
            editor.insertText("\t\t" + splitText[2] + ".apply(this);\n");
        }`
        editor.insertText("\t}\n")
        `if(shouldProto) {
            editor.insertText("\n");
            editor.insertText("\t" + className + ".prototype = Object.create(" + splitText[2] + ".prototype);\n");
            editor.insertText("\t" + className + ".prototype.constructor = " + className + ";\n");
        }`
        editor.insertText("\n")
        editor.insertText("\treturn " + className + ";")
        editor.insertText("\n}());")
