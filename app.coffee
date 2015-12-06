require('dotenv').load()

Slack = require 'slack-client'
commands = require './src/commands'

logCommand = new commands.LogCommand()

slack = new Slack(process.env.SLACK_TOKEN, autoReconnect = true, autoMark = true)

slack.on 'open', ->
  console.log "Connected to #{slack.team.name} as @#{slack.self.name}"

slack.on 'error', (err) ->
  console.error "Error", err

slack.on 'message', (message) ->
  message = MessageDecorator(message)

  if message?
    options = {
      text: message.text,
      channel: message.channelName,
      user: message.userName,
      ts: message.ts,
      bot: slack.self.id
    }

    command = commands.createCommand(options)

    if command?
      command.execute (res) ->
        if command.respondToRequester
          slack.getDMByName(message.userName).send res
        else
          slack.getChannelByID(message.channel).send res

    #log everything
    logCommand.execute(options)


MessageDecorator = (msg) ->
  if msg.user?
    msg.userName = slack.getUserByID(msg.user).name
  if msg.channel?
    msg.channelName =  slack.getChannelGroupOrDMByID(msg.channel).name
  msg

slack.login()
