
Template = require "./template.coffee"

class JavascriptTemplate extends Template

    constructor: ->
        super

    generateClass: (classdef) ->
        buffer = ""
        # Start the class
        buffer += "#{classdef.fullname} = (function() {\n"

        buffer += @indent(@generateMethod(classdef.name, null, classdef.parameters, "constructor", {
            "before": "#{classdef.extends}.apply(this, arguments);" if classdef.extends
        }), 1)

        # If classdef extends another class, add appropriate code
        if classdef.extends
            buffer += "\n"
            buffer += "#{@tabString}#{classdef.name}.prototype = Object.create(#{classdef.extends}.prototype);\n"
            buffer += "#{@tabString}#{classdef.name}.prototype.constructor = #{classdef.name};\n"

        if classdef.methods.length > 0
            for method in [0..classdef.methods.length - 1]
                if method >= 0
                    buffer += "\n"

                method = classdef.methods[method]
                buffer += @indent(@generateMethod(classdef.name, method.name, method.parameters, method.type), 1)

        buffer += "\n"
        buffer += "#{@tabString}return #{classdef.name};"
        buffer += "\n}());"

        buffer

    generateMethod: (className, method, parameters, type = "member", body = {}) ->
        if type == "static"
            buffer = "#{className}.#{method} = function("
        else if type == "method"
            buffer = "#{className}.prototype.#{method} = function("
        else if type == "constructor"
            buffer = "function #{className}("

        if parameters.length > 0
            for param in [0..parameters.length - 1]
                if param == parameters.length - 1
                    buffer += parameters[parameters.length - 1].name + ") {\n"
                else
                    buffer += parameters[param].name + ", "
        else
            buffer += ") {\n"

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
                    buffer += "#{@tabString}if (typeof #{param.name} !== \"#{param.type}\") throw new Error(\"Parameter '#{param.name}' expects to be type '#{param.type}'\");\n"
                if param.instance
                    checks = true
                    buffer += "#{@tabString}if (!(#{param.name} instanceof #{param.instance})) throw new Error(\"Parameter '#{param.name}' expects to be instance of '#{param.instance}'\");\n"


        if parameters.length > 0 && members
            buffer += "\n" if checks
            for param in [0..parameters.length - 1]
                param = parameters[param]
                if param.member
                    buffer += "#{@tabString}this.#{param.name} = #{param.name};\n"

        if body.after
            buffer += "\n" if checks || members
            buffer += "#{@indent(body.after, 1)}"

        buffer += "}"

        return buffer

module.exports = new JavascriptTemplate
