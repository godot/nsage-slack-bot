Storage = require './store'
JokeCommand = require './jokes'
ParseCommand = require './parse'

exports.JokeCommand = JokeCommand

class LogCommand
  execute: (options) ->
    storage = new Storage()
    storage.save options

exports.LogCommand = LogCommand

class SearchCommand
  respondToRequester: true

  constructor: (@query) ->
    @storage = new Storage()

  execute: (cb, err) ->
    @storage.search @query, cb

exports.SearchCommand = SearchCommand

class CommandBuilder
  @commands = {
    q : SearchCommand
    parse : ParseCommand
    joke: JokeCommand
  }

  constructor: (options) ->
    @text = options.text
    @bot  = options.bot
    try
      @parseText()
    catch error
      console.log "Error:" + error
      console.log options

  commandRegExp: () ->
    new RegExp("<@"+@bot+">: (q|joke|parse) (.+)")

  parseText: () ->
    [_, @commandName, @params] = @text.match(@commandRegExp()) || []

  isCommand: ->
    @text? && @commandName?

  command: ->
    return unless @isCommand()
    console.log 'executing:', @commandName, " with ", @params
    new CommandBuilder.commands[@commandName](@params)


exports.createCommand = (options) ->
  new CommandBuilder(options).command()

exports.CommandBuilder = CommandBuilder
