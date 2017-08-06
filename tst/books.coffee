ZohoSDK = require '../index'

books = new ZohoSDK.Books()

books.listTimeEntries 
  filter_by: 'Date.ThisWeek'
, (err, res) ->
  console.log JSON.stringify res, null, 2

books.logTimeEntries
  project_id: '826337000000059101'
  task_id: '826337000000075047'
  user_id: '826337000000059083'
  log_date: '2017-05-01'
  begin_time: '10:00'
  end_time: '15:00'
, (err, res) ->
  console.log JSON.stringify res, null, 2 if res

