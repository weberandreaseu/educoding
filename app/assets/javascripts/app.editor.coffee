#=require ace/base
#=require ace/markdown
#=require ace/java

# array to store the editor instances
editors = []

class Editor
  constructor: (@editable) ->
    console.log 'init editor - editable: ' + @editable

    # init description editor for editable sessions
    if @editable
      this.initEditor 'editor_description', 'markdown'
      this.initEditor 'editor_basic_test', 'java'
      this.initEditor 'editor_advanced_test', 'java'

    # set frist tab / pane to active
    $('#class_file_tabs > .nav-item > .nav-link').first().addClass('active')
    panes = $('.tab-content').children('div.tab-pane')
    panes.first().addClass('active')

    # init editor for each tab
    for pane in panes
      this.initEditor pane.id, 'java'
    this.updateEventListener()

  initEditor: (id, language) ->
    console.log id
    editor = ace.edit id
    editor.setTheme 'ace/theme/chrome'
    editor.getSession().setMode 'ace/mode/' + language
    editor.$blockScrolling = Infinity
    editor.setOptions
      enableBasicAutocompletion: true
      enableSnippets: true
    editors.push([editor, id])


  renameClassFile: (class_file) ->
    class_file.prop('readonly', false)
    class_file.focusout ->
      class_file.prop('readonly', true)
      return

  updateEventListener: ->
    $('[data-toggle="tooltip"]').tooltip()
    tmp = this
    $(document.body).on 'dblclick', '.class_file_name.editable', ->
      tmp.renameClassFile($(this))
      return

  addClassFile: (class_file) ->
    file_id = class_file.children('input.class_file_name').attr('id')
    file_id = file_id.replace('_filename', '')
    class_file.wrapInner('<a class="nav-link class_file_tab editable" href="#' + file_id + '" role="tab" data-toggle="tab"></a>')
    $('#class-file-panes').append('<div id="' + file_id  + '" class="tab-pane" role="tabpanel">// Your java code</div>')
    checkbox = class_file.find('a label')
    checkbox.prependTo(class_file)
    this.initEditor file_id, 'java'
    this.updateEventListener()

  saveClassFiles: ->
    for editor in editors
      # get the editor content
      code = editor[0].getValue()
      id = editor[1]
      selector = '#' + id + '_code'
      # set the value of input field
      $(selector).val code

$(document).on "turbolinks:load", ->
  # init editable editor only in tasks#new / tasks#edit
  if $(".tasks.new").length > 0 || $(".tasks.edit").length > 0
    editor = new Editor true
  # init non editable editor in solutions#new /solutions#edit
  else if $(".solutions.new").length > 0 || $(".solutions.edit").length > 0
    editor = new Editor false
    # set hidden field for run true
    $('#run-solution').click ->
      editor.saveClassFiles()
      $('#solution_run').val true
      return
    # set hidden field for run false
    $('#save-solution').click ->
      $('#solution_run').val false
      return
  else
    return

  $('#add-class-file').click ->
    editor.saveClassFiles()
    return

  $('#save-solution').click ->
    editor.saveClassFiles()
    return

  $('#class_files').on('cocoon:after-insert', (e, new_class_file) ->
    editor.addClassFile new_class_file
    return
  )