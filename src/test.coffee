require('dotenv').load()
commands = require './commands'

exports.testSearchCommand = (test) ->
  test.ok commands.CommandBuilder.commands.q
  test.done()

exports.testRequestSearchCommand = (test) ->
  cb = commands.createCommand({bot: 'U0F57MJR5', text: "<@U0F57MJR5>: q styczniu"})
  cb.execute (data) ->
    test.ok data
    test.done()

exports.testNonexistentCommand = (test) ->
  cb = commands.createCommand({bot: 'U0F57MJR5',text: "<@U0F57MJR5>: s styczniu"})

  test.ok !cb
  test.done()


exports.testCommandBuilder = (test) ->
  cb = new commands.CommandBuilder({bot: 'U0F57MJR5',text: "<@U0F57MJR5>: q styczniu"})

  test.equal cb.bot, 'U0F57MJR5'
  test.ok cb.isCommand()
  test.equal cb.commandName, 'q'
  test.equal cb.params, 'styczniu'
  test.ok cb.command
  test.done()
