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

    panes = $('.tab-content').children('div.tab-pane')

    # set frist tab / pane to active
    $('#class_file_tabs > .nav-item > .nav-link').first().addClass('active')
    panes.first().addClass('active')

    # init editor for each tab
    for pane in panes
      this.initEditor pane.id, 'java'
    this.updateEventListener()

  # init ace editor
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
    input = class_file.children()
    input.prop('readonly', false)

    class_file.focusout ->
      input.prop('readonly', true)
      return

  updateEventListener: ->
    tmp = this
    $('.class_file_tab.editable').dblclick ->
      tmp.renameClassFile($(this))
      return

    # TODO: make new tabs selectable

  addClassFile: (class_file) ->
    file_id = class_file.children('input').attr('id')
    file_id = file_id.replace('_filename', '')
    class_file.wrapInner('<a class="nav-link class_file_tab" href="#' + file_id + '"></a>')
    $('#class-file-panes').append('<div id="' + file_id + '" class="tab-pane" role="tabpanel">// Your java code</div>')
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


$(document).on "page:change", ->
  # init editable editor only in tasks#new / tasks#edit
  if $(".tasks.new").length > 0 || $(".tasks.edit").length > 0
    editor = new Editor true
  # init non editable editor in solutions#new /solutions#edit
  else if $(".solutions.new").length > 0 || $(".solutions.edit").length > 0
    editor = new Editor false
    # set hidden field for run true
    $('#run-solution').click ->
      $('#solution_run').val true
    # set hidden field for run false
    $('#save-solution').click ->
      $('#solution_run').val false
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