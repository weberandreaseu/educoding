#=require ace/base
#=require ace/markdown

$(document).ready ->
	editor = ace.edit('editor')
	editor.setTheme 'ace/theme/chrome'
	editor.getSession().setMode 'ace/mode/markdown'

	# disable scrolling logs in console
	editor.$blockScrolling = Infinity

	# editor options
	editor.setOptions
		enableBasicAutocompletion: true
		enableSnippets: true

	$('#new-task').click ->
		description = editor.getValue()
		$('#task_description').val description
	return
return