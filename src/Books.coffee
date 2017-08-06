ZohoSDK = require './ZohoSDK'

class Books extends ZohoSDK

  constructor: (config = {}) ->
    config['endpoint'] or= 'https://books.zoho.com/api'
    super config

  ## Projects
  # https://www.zoho.com/books/api/v3/#Projects
  createProject: (body, callback) ->
    @_sendRequest 'POST', "/v3/projects", null, body, callback
    
  updateProject: (projectId, body, callback) ->
    @_sendRequest 'PUT', "/v3/projects/#{projectId}", null, body, callback
    
  listProjects: (params, callback) ->
    @_sendRequest 'GET', "/v3/projects", params, null, callback
    
  getProject: (projectId, callback) ->
    @_sendRequest 'GET', "/v3/projects/#{projectId}", null, null, callback
    
  getActiveProjectByName: (projectName, callback) ->
    @listProjects filter_by: 'Status.Active', (err, res) ->
      for project in res.projects
        if project.project_name.match(new RegExp(projectName, 'i'))
          return callback err, project
      return callback 'no projects match'
    
  deleteProject: (projectId, callback) ->
    @_sendRequest 'DELETE', "/v3/projects/#{projectId}", null, null, callback
    
  activateProject: (projectId, callback) ->
    @_sendRequest 'POST', "/v3/projects/#{projectId}/active", null, null, callback
    
  deactivateProject: (projectId, callback) ->
    @_sendRequest 'POST', "/v3/projects/#{projectId}/inactive", null, null, callback
    
  cloneProject: (projectId, body, callback) ->
    @_sendRequest 'POST', "/v3/projects/#{projectId}/clone", null, body, callback
    
  assignUsersToProject: (projectId, body, callback) ->
    @_sendRequest 'POST', "/v3/projects/#{projectId}/users", null, body, callback
    
  inviteUserToProject: (projectId, body, callback) ->
    @_sendRequest 'POST', "/v3/projects/#{projectId}/users/invite", null, body, callback
    
  updateProjectUser: (projectId, projectUserId, body, callback) ->
    @_sendRequest 'PUT', "/v3/projects/#{projectId}/users/#{projectUserId}", null, body, callback
    
  listProjectUsers: (projectId, callback) ->
    @_sendRequest 'GET', "/v3/projects/#{projectId}/users", null, null, callback
    
  getProjectUser: (projectId, projectUserId, callback) ->
    @_sendRequest 'GET', "/v3/projects/#{projectId}/users/#{projectUserId}", null, null, callback
    
  getProjectUserByEmail: (username, projectId, callback) ->
    @listProjectUsers projectId, (err, res) ->
      for user in res.users
        if user.email.match(new RegExp(username, 'i'))
          return callback err, user
      return callback 'no users match'
    
  deleteProjectUser: (projectId, projectUserId, callback) ->
    @_sendRequest 'DELETE', "/v3/projects/#{projectId}/users/#{projectUserId}", null, null, callback
    
  createProjectComment: (projectId, body, callback) ->
    @_sendRequest 'POST', "/v3/projects/#{projectId}/comments", null, body, callback
    
  listProjectComments: (projectId, callback) ->
    @_sendRequest 'GET', "/v3/projects/#{projectId}/comments", null, null, callback
    
  deleteProjectComment: (projectId, commentId, callback) ->
    @_sendRequest 'DELETE', "/v3/projects/#{projectId}/comment/#{commentId}", null, null, callback
    
  listProjectInvoices: (projectId, params, callback) ->
    @_sendRequest 'GET', "/v3/projects/#{projectId}/invoices", params, null, callback

  ## Tasks
  # https://www.zoho.com/books/api/v3/#Tasks
  addTask: (projectId, body, callback) ->
    @_sendRequest 'POST', "/v3/projects/#{projectId}/tasks", null, body, callback
    
  updateTask: (projectId, taskId, body, callback) ->
    @_sendRequest 'PUT', "/v3/projects/#{projectId}/tasks/#{taskId}", null, body, callback
    
  listTasks: (projectId, body, callback) ->
    @_sendRequest 'GET', "/v3/projects/#{projectId}/tasks", null, body, callback
    
  getTask: (projectId, taskId, callback) ->
    body = task_id: taskId
    @_sendRequest 'GET', "/v3/projects/#{projectId}/tasks/#{taskId}", null, body, callback
    
  getTaskByName: (taskName, projectId, callback) ->
    @listTasks projectId, null, (err, res) ->
      for task in res.task
        if task.task_name.match(new RegExp(taskName, 'i'))
          return callback err, task
      return callback 'no tasks match'
    
  deleteTask: (projectId, taskId, callback) ->
    body = task_id: taskId
    @_sendRequest 'DELETE', "/v3/projects/#{projectId}/tasks/#{taskId}", null, body, callback
    
  ## Time-Entries
  # https://www.zoho.com/books/api/v3/#Time-Entries
  logTimeEntry: (body, callback) ->
    missingElements = @assertElements body, ['project_id','task_id','user_id','log_date']
    return callback missingElements if missingElements
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
    return callback missingElements if missingElements
    @_sendRequest 'DELETE', '/v3/projects/timeentries/' + id, null, body, callback
    
  startTimer: (timeEntryId, callback) ->
    @_sendRequest 'POST', "/v3/projects/timeentries/#{timeEntryId}/timer/start", null, null, callback
    
  stopTimer: (time_entry_id, callback) ->
    @_sendRequest 'POST', '/v3/projects/timeentries/timer/stop', null, null, callback
    
  getTimer: (callback) ->
    @_sendRequest 'GET', '/v3/projects/timeentries/runningtimer/me', null, null, callback

module.exports = Books
