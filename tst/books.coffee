{Books} = require '../index'

books = new Books()

books.listTimeEntries 
  filter_by: 'Date.ThisWeek'
, (err, res) ->
  console.log JSON.stringify res, null, 2
