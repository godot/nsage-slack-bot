elasticsearch = require 'elasticsearch'

client = new elasticsearch.Client host: process.env.ELASTICSEARCH_HOST

class Storage
  save: (data) ->
    client.create {index: '350pixels', type: 'log', body: data}

  search: (query, callBack) ->
    client.search {index: '350pixels', type: 'log', q: query}, (err, resp) ->
      if err
        callBack(err)
      else
        callBack extractResponse(resp)


extractResponse = (body) ->
  body.hits.hits.map (r) ->
    {user, text, ts} = r._source
    [user, ts, "said:", text].join(" ")
  .join("\n")


module.exports = Storage
