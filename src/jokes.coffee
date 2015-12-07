request = require 'request'

class JokeCommand

  URL = 'http://api.icndb.com/jokes/random?firstName=<FIRSTNAME>&lastName=<LASTNAME>&limitTo=nerdy'

  constructor: (params) ->
    [@firstName, @lastName] = params.split(' ')

  execute: (cb, err) ->
    request @url(), (err, res, data) ->
      console.log('error in jokecommand:', err) if err
      cb(JSON.parse(data).value.joke)

  url: () ->
    URL.replace('<FIRSTNAME>',@firstName).replace('<LASTNAME>', (@lastName || "Jr."))


module.exports = JokeCommand
