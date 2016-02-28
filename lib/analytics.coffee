
net = require "net"

class Analytics
	constructor: (address, port) ->
		@address = address
		@port = port

		@client = new net.Socket()
		@client.connect @port, @address, (->
			console.log "Connected to #{@address}, #{@port}"
			@client.write "PING"
		).bind(this)

		@client.on "data", (data) ->
			console.log data.toString()

		@client.on "close", ->
			console.log "Lost connection to server"

	addComplete: ->
		console.log "Adding complete"
		@client.write("COMP")

module.exports = Analytics
