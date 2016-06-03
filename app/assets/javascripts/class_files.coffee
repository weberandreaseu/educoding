$(document).ready ->
  # example showing manipulating the inserted/removed item
  $('#class_files').on('cocoon:after-insert', (e, task_to_be_added) ->
    task_to_be_added.fadeIn 'slow'
    return
  )
  return