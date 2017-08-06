ZohoSDK = require './ZohoSDK'

class Books extends ZohoSDK

  constructor: (config = {}) ->
    config['endpoint'] or= 'https://books.zoho.com/api'
    super config

  ## Tasks
  # https://www.zoho.com/books/api/v3/#Tasks
  addTask: (projectId, body, callback) ->
    @_sendRequest 'POST', "/v3/projects/#{projectId}/tasks", null, body, callback
    
  updateTask: (projectId, taskId, body, callback) ->
    @_sendRequest 'PUT', "/v3/projects/#{projectId}/tasks/#{taskId}", null, body, callback
    
  listTasks: (projectId, body, callback) ->
    @_sendRequest 'GET', "/v3/projects/#{projectId}/tasks", null, body, callback.
    
  getTask: (projectId, taskId, callback) ->
    body = task_id: taskId
    @_sendRequest 'GET', "/v3/projects/#{projectId}/tasks/#{taskId}", null, body, callback
    
  deleteTask: (projectId, taskId, callback) ->
    body = task_id: taskId
    @_sendRequest 'DELETE', "/v3/projects/#{projectId}/tasks/#{taskId}", null, body, callback
    
  ## Time-Entries
  # https://www.zoho.com/books/api/v3/#Time-Entries
  logTimeEntries: (body, callback) ->
    missingElements = @assertElements body, ['project_id','task_id','user_id','log_date']
    return callback missingElements if missing_elements
    @_sendRequest 'POST', '/v3/projects/timeentries', null, body, callback
    
  updateTimeEntries: (id, body, callback) ->
    @_sendRequest 'PUT', '/v3/projects/timeentries/' + id, null, body, callback

  listTimeEntries: (params, callback) ->
    @_sendRequest 'GET', '/v3/projects/timeentries', params, null, callback

  getTimeEntry: (id, callback) ->
    @_sendRequest 'GET', '/v3/projects/timeentries/' + id, null, null, callback
    
  deleteTimeEntry: (id, callback) ->
    @_sendRequest 'DELETE', '/v3/projects/timeentries/' + id, null, null, callback
    
  deleteTimeEntries: (body, callback) ->
    missingElements = @assertElements body, ['time_entry_ids']
    return callback missingElements if missing_elements
    @_sendRequest 'DELETE', '/v3/projects/timeentries/' + id, null, body, callback
    
  startTimer: (timeEntryId, callback) ->
    @_sendRequest 'POST', "/v3/projects/timeentries/#{timeEntryId}/timer/start", null, null, callback
    
  stopTimer: (time_entry_id, callback) ->
    @_sendRequest 'POST', '/v3/projects/timeentries/timer/stop', null, null, callback
    
  getTimer: (callback) ->
    @_sendRequest 'GET', '/v3/projects/timeentries/runningtimer/me', null, null, callback

module.exports = Books
