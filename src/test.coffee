require('dotenv').load()
commands = require './commands'

exports.testSearchCommand = (test) ->
  test.ok commands.CommandBuilder.commands.q
  test.done()

exports.testJokeCommand = (test) ->
  test.ok commands.CommandBuilder.commands.joke
  test.done()


exports.testRequestJokeCommand = (test) ->
  cb = commands.createCommand({bot: 'U0F57MJR5', text: "<@U0F57MJR5>: joke fir lat"})
  cb.execute (data) ->
    console.log data
    test.ok data
    test.done()


exports.testRequestSearchCommand = (test) ->
  cb = commands.createCommand({bot: 'U0F57MJR5', text: "<@U0F57MJR5>: q test"})
  cb.execute (data) ->
    test.ok data
    test.done()

exports.testNonexistentCommand = (test) ->
  cb = commands.createCommand({bot: 'U0F57MJR5',text: "<@U0F57MJR5>: s test"})

  test.ok !cb
  test.done()


exports.testCommandBuilder = (test) ->
  cb = new commands.CommandBuilder({bot: 'U0F57MJR5',text: "<@U0F57MJR5>: q test"})

  test.equal cb.bot, 'U0F57MJR5'
  test.ok cb.isCommand()
  test.equal cb.commandName, 'q'
  test.equal cb.params, 'test'
  test.ok cb.command
  test.done()


exports.testCommandBuilder = (test) ->
  cb = new commands.CommandBuilder({bot: 'U0F57MJR5',text: "<@U0F57MJR5>: joke mister plaster"})

  test.equal cb.bot, 'U0F57MJR5'
  test.ok cb.isCommand()
  test.equal cb.commandName, 'joke'
  test.equal cb.params, 'mister plaster'
  test.ok cb.command
  test.done()
