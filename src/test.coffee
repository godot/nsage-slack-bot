Command = require './commands'
Storage = require './store'


exports.testSearchCommand = (test) ->
  storage = new Storage()
  builder = new Command()

  test.ok Command.commands.q.execute
  test.done()


exports.testRequestSearchCommand = (test) ->
  cb = new Command('@U0F57MJR5',"<@U0F57MJR5>: q styczniu")

  cb.execute (err, data) ->
    test.ok data
    test.ok !err
    test.done()

exports.testNonexistentCommand = (test) ->
  cb = new Command('@U0F57MJR5',"<@U0F57MJR5>: s styczniu")

  test.ok !cb.isCommand()
  test.done()


exports.testCommandBuilder = (test) ->
  cb = new Command('@U0F57MJR5',"<@U0F57MJR5>: q styczniu")

  test.equal cb.botName, '@U0F57MJR5'
  test.ok cb.isCommand()
  test.equal cb.commandName, 'q'
  test.equal cb.params, 'styczniu'
  test.ok cb.command
  test.done()
