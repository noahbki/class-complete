
class Complete
    constructor: ->
        @tabString = "\t";
        tabLength = atom.config.get("editor.tabLength")
        if atom.config.get("editor.tabType") != "hard"
            @tabString = ""
            i = 0
            while i < tabLength
                i++
                @tabString += " "

        @templates = {
            "js": {
                "filetypes": [
                    ".js"
                ],
                "complete": require "./templates/javascript.coffee"
            }
        }

        for template in @templates
            template.tabString = @tabString

    activate: ->
        atom.commands.add "atom-workspace",
            "class-complete:complete": => @complete()

    complete: ->
        buffer = ""
        editor = atom.workspace.getActivePaneItem()
        cursor = editor.cursors[0]
        text = editor.getSelections()[0].getText()

        # Parse classdef to find out what needs to be generated
        classdef = @parseClassdef(text)

        fileName = editor.getFileName().split(".")[..].pop()
        console.log fileName

        buffer = @templates["js"].generateClass(classdef)

        editor.insertText buffer

    parseClassdef: (string) ->
        # <class_name>:<arguments>,...;<methods>,...:<extend>

        def = {
            fullname: null
            name: null,
            parameters: [],
            methods: [],
            extends: null,
            requireLines: []
        }

        fullname = string.split(":")[0]

        def.fullname = fullname

        string = string.replace(/\s/g, "")
        parts = string.split(":")

        if parts.length > 0
            def.name = parts[0]
            if parts.length > 1
                parameth = parts[1].split(";")
                parameters = parameth[0]
                methods = parameth[1]

                if parameters
                    def.parameters = @parseParameters(parameters)

                if methods

                    methods2 = methods.split("/")
                    for method in methods2
                        meth = {
                            name: null,
                            parameters: []
                            type: "method"
                        }

                        if method[0] == "@"
                            meth.type = "static"
                            method = method.substr(1, method.length - 1)

                        methsplit = method.split("+")
                        meth.name = methsplit[0] if methsplit.length > 0

                        meth.parameters = @parseParameters(methsplit[1]) if methsplit.length > 1

                        def.methods.push(meth) if meth.name

            if parts.length > 2
                def.extends = parts[2]

        return def

    parseParameters: (string) ->
        params = []

        string = string.replace(/\s/g, "").split(",")

        for part in string
            param = {
                name: null
                type: null
                instance: null
                member: false
                modes: []
            }

            parts = part.split("~")
            if parts.length > 1
                param.modes = parts[1].split("")
                part = parts[0]

            if part[0] == "@"
                param.member = true
                part = part.substr(1, part.length - 1)

            if part.split("!").length > 1
                split = part.split("!")

                param.name = split[0]
                param.type = split[1]
            else if part.split("^").length > 1
                split = part.split("^")

                param.name = split[0]
                param.instance = split[1]
            else
                param.name = part

            params.push(param)

        return params

module.exports = new Complete
