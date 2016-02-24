
class CompleteHandler
	constructor: ->

	complete: (completeInstance) ->
		@templates = completeInstance.templates
		buffer = ""
		editor = atom.workspace.getActivePaneItem()
		cursor = editor.cursors[0]
		text = editor.getSelections()[0].getText()

		classdef = @parseClassdef(text)

		fileName = editor.getFileName()
		if fileName
			fileName = fileName.split(".")[..].pop()
			completed = false
			for key of @templates
				if completed
					break
				template = @templates[key]
				for fileType in template.fileTypes
					if fileType.toLowerCase() == fileName.toLowerCase()
						buffer += template.complete.generateClass(classdef)
						completed = true
						break
			if !completed
				buffer += @templates[@default].complete.generateClass(classdef)
		else
			buffer += @templates[@default].complete.generateClass(classdef)

		editor.insertText buffer

	parseClassdef: (string) ->
		def = {
			fullname: null
			name: null,
			parameters: [],
			methods: [],
			extends: null
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

	updateTemplates: ->
		@templates = @completeInstance.getTemplates()

module.exports = CompleteHandler
