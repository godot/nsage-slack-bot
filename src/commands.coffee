Storage = require './store'

class LogCommand
  execute: (options) ->
    storage = new Storage()
    storage.save options

exports.log = LogCommand


class SearchCommand
  constructor: () ->
    @storage = new Storage()

  execute: (query, cb, err) ->
    @storage.search query, cb


class CommandBuilder
  @commands = {
    q : new SearchCommand()
  }

  constructor: (options) ->
    @text = options.text

    @commandRegExp = new RegExp("<@"+options.bot+">: ([q]) (.*)")

    if cmd = @isCommand()
      @commandName = cmd[1]
      @params = cmd[2]

  isCommand: ->
    @text && @text.match(@commandRegExp)

  command: ->
    CommandBuilder.commands[@commandName]

  execute: (callback,error) ->
    return unless @isCommand()

    @command().execute @params, callback

exports.Builder = CommandBuilder
