ZohoSDK = require './ZohoSDK'

class Books extends ZohoSDK

  constructor: (config = {}) ->
    config['endpoint'] or= 'https://books.zoho.com/api'
    super config

  ## Time-Entries
  # https://www.zoho.com/books/api/v3/#Time-Entries
  logTimeEntries: (params, body, callback) ->
    @_sendRequest 'GET', '/v3/projects/timeentries', params, body, callback

  listTimeEntries: (params, callback) ->
    @_sendRequest 'GET', '/v3/projects/timeentries', params, null, callback

  getTimeEntry: (id, callback) ->
    @_sendRequest 'GET', '/v3/projects/timeentries/' + id, null, null, callback

module.exports = Books
