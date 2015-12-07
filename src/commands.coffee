Storage = require './store'
JokeCommand = require './jokes'

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
    q : SearchCommand,
    joke: JokeCommand
  }

  constructor: (options) ->
    @text = options.text
    @bot  = options.bot
    @parseText()

  commandRegExp: () ->
    new RegExp("<@"+@bot+">: (q|joke) (.+)")

  parseText: () ->
    args = @text.match(@commandRegExp())
    if args?
      @commandName = args[1]
      @params = args[2]

  isCommand: ->
    @text? && @commandName?

  command: ->
    return unless @isCommand()
    console.log 'executing:', @commandName, " with ", @params
    new CommandBuilder.commands[@commandName](@params)


exports.createCommand = (options) ->
  new CommandBuilder(options).command()

exports.CommandBuilder = CommandBuilder
