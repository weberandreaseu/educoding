$(document).ready ->
  # TODO: extract to function
  $('.class_file_tab').dblclick ->
      $(this).children().prop('readonly', false);
      console.log 'editable'
      return
  $('#class_files').on('cocoon:before-insert', (e, task_to_be_added) ->
    console.log 'before insert'
    return
  ).on('cocoon:after-insert', (e, added_class_file) ->
    console.log 'after insert'
    input_field = added_class_file.children('input')
    file_id = input_field.attr('id')
    console.log file_id
    added_class_file.wrapInner('<a class="nav-link class_file_tab" href="#' + file_id  + '_tab"></a>')

    # bind rename by doubleclick
    $('.class_file_tab').dblclick ->
      $(this).children().prop('readonly', false);
      console.log 'editable'
      return
    
  ).on 'cocoon:before-remove', (e, task) ->
    console.log 'before remove'
    return
  return