
class CoffeeTemplate

    constructor: ->
        @tabString = "\t"

    generateClass: (classdef) ->
        buffer = ""
        buffer += "class #{classdef.fullname}"
        buffer += " extends #{classdef.extends}" if classdef.extends

        buffer += @indent(@generateMethod(classdef.name, null, classdef.parameters, "constructor", {
            "before": "super" if classdef.extends
        }), 1)

        if classdef.methods.length > 0
            for method in [0..classdef.methods.length - 1]

                method = classdef.methods[method]
                buffer += @indent(@generateMethod(classdef.name, method.name, method.parameters, method.type), 1)

        buffer.substr(0, buffer.length - 2)

    generateMethod: (className, method, parameters, type = "member", body = {}) ->
        buffer = ""
        if type == "static"
            buffer += "@#{method}: ("
        else if type == "method"
            buffer += "#{method}: ("
        else if type == "constructor"
            buffer += "\nconstructor: ("

        if parameters.length > 0
            for param in [0..parameters.length - 1]
                if param == parameters.length - 1
                    buffer += parameters[parameters.length - 1].name + ") ->\n"
                else
                    buffer += parameters[param].name + ", "
        else
            buffer += ") ->\n"

        buffer += "#{@indent(body.before, 1)}" if body.before

        checks = false
        members = false

        if parameters.length > 0
            buffer += "\n" if body.before
            for param in [0..parameters.length - 1]
                param = parameters[param]

                if param.member
                    members = true

                if param.type
                    checks = true
                    buffer += "#{@tabString}if typeof #{param.name} isnt \"#{param.type}\" \n#{@tabString}#{@tabString}throw new Error(\"Parameter '#{param.name}' expects to be type '#{param.type}'\")\n"
                if param.instance
                    checks = true
                    buffer += "#{@tabString}if !(#{param.name} instanceof #{param.instance}) \n#{@tabString}#{@tabString}throw new Error(\"Parameter '#{param.name}' expects to be instance of '#{param.instance}'\")\n"


        if parameters.length > 0 && members
            buffer += "\n" if checks
            for param in [0..parameters.length - 1]
                param = parameters[param]
                if param.member
                    buffer += "#{@tabString}@#{param.name} = #{param.name}\n"

        if body.after
            buffer += "\n" if checks || members
            buffer += "#{@indent(body.after, 1)}"

        return buffer

    indent: (text, indent) ->
        buffer = ""
        lines = text.split(/\n|\r\n/)

        prefix = ""
        prefix += "#{@tabString}" for i in [0..indent - 1]

        for line in lines
            buffer += prefix + line + "\n"

        return buffer

module.exports = new CoffeeTemplate
