require('dotenv').load()

Slack = require 'slack-client'
commands = require './src/commands'

log = new commands.log()

slackToken = process.env.SLACK_TOKEN
autoReconnect = true
autoMark = true

slack = new Slack(slackToken, autoReconnect, autoMark)

slack.on 'open', ->
  console.log "Connected to #{slack.team.name} as @#{slack.self.name}"

slack.on 'error', (err) ->
  console.error "Error", err

slack.on 'message', (message) ->
  channel = slack.getChannelGroupOrDMByID(message.channel)
  user = slack.getUserByID(message.user)

  console.log 'message:', message
  console.log 'channel:', channel

  if channel? && user? && message?
    commandOptions = {
      text: message.text,
      channel: channel.name,
      user: user.name,
      ts: message.ts,
      bot: slack.self.id
    }

    command = new commands.Builder(commandOptions)

    command.execute (res) ->
      channel.send res

    log.execute(commandOptions)


slack.login()
