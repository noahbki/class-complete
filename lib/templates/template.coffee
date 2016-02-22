
class Template
    constructor: ->
        @tabString = "\t" # Defaults to this

    indent: (text, indent) ->
        console.log text
        console.log indent
        buffer = ""
        lines = text.split(/\n|\r\n/)

        prefix = ""
        prefix += "#{@tabString}" for i in [0..indent - 1]

        for line in lines
            buffer += prefix + line + "\n"

        return buffer

module.exports = Template
