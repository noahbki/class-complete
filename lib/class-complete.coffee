
CompleteHandler = require "./complete-handler.coffee"

Analytics = require "./analytics.coffee"

class Complete
	constructor: ->
		@completeHandler = new CompleteHandler
		@tabString = "\t";
		tabLength = atom.config.get("editor.tabLength")
		if atom.config.get("editor.tabType") != "hard"
			@tabString = ""
			i = 0
			while i < tabLength
				i++
				@tabString += " "

		# Accepts an object
		# "<filetype>": require "./templates/<pathtotemplate>.coffee
		@templates =
			"js":
				"complete":
					require "./templates/javascript.coffee"
				"fileTypes":
					["js"]

			"coffee":
				"complete":
					require "./templates/coffee.coffee"
				"fileTypes":
					["coffee"]

		for template in @templates
			template.tabString = @tabString

		@analytics = new Analytics "188.166.153.254", 13337

	complete: ->
		@completeHandler.complete(@)
		try
			@analytics.addComplete()
		catch error
			console.log error

	activate: ->
		console.log "Activated Class Complete!"
		atom.commands.add "atom-workspace",
			"class-complete:complete": => @complete()

	addTemplate: (templateInfo) ->
		@templates[templateInfo.name] = templateInfo
		console.log "Template added: ", templateInfo
		console.log @templates

	getTemplates: ->
		return @templates

	provideClasscomplete: ->
		console.log "Providing service"
		return @addTemplate.bind(@)

complete = new Complete
module.exports = complete
