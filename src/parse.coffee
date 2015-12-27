Push = require "parse-push"

class ParseCommand
  constructor: (@query) ->
    @push = new Push applicationId: process.env.PARSE_APP_ID, restApiKey: process.env.PARSE_REST_API_KEY

  execute: (cb, err) ->
    @push.sendToChannels ["test"], {alert: @query}, (error, data) ->
      if error
        console.log "Oh no it went wrong!: " + error.message
      else
        console.log "It went well! ", data

module.exports = ParseCommand
