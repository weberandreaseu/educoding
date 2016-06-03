#=require ace/base
#=require ace/markdown
#=require ace/java

class Editor
	constructor: (@editable) ->
		console.log 'init editor'
		tabs = $('.tab-content').children('div.tab-pane')

		$('#class_file_tabs > .nav-item > .nav-link').first().addClass('active')
		$('#class_files > .tab-content > .tab-pane').first().addClass('active')

		for tab in tabs
			this.initEditor tab, 'java'

	# init ace for the tab
	initEditor: (tab, language) ->
		editor = ace.edit tab.id
		editor.setTheme 'ace/theme/chrome'
		editor.getSession().setMode 'ace/mode/' + language
		editor.$blockScrolling = Infinity
		editor.setOptions
			enableBasicAutocompletion: true
			enableSnippets: true
			wrap: 100

	addClassFile: (class_file) ->
    file_id = class_file.children('input').attr('id')
    class_file.wrapInner('<a class="nav-link class_file_tab" href="#' + file_id  + '_tab"></a>')
    

	renameClassFile: (class_file) ->
		console.log class_file
		class_file.children().prop('readonly', false);

	updateEventListener: ->
		console.log 'event listnener updated'
		$('.class_file_tab').dblclick ->
			renameClassFile $(this)
			return


$(document).on "page:change", ->
 	# init editor only in tasks#new / tasks#edit
	return unless $(".tasks.new").length > 0 || $(".tasks.edit").length > 0
	editor = new Editor true

	$('#class_files').on('cocoon:after-insert', (e, new_class_file) ->
    editor.addClassFile new_class_file
    return
  )