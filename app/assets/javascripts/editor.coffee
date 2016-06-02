#=require ace/base
#=require ace/markdown

initEditor = ->
	# only use editor in tasks/new
	return unless $(".tasks.new").length > 0 || $(".tasks.edit").length > 0

	console.log 'editor initialized'

	# initialize editor
	# editor = ace.edit('description-editor')
	# editor.setTheme 'ace/theme/chrome'
	# editor.getSession().setMode 'ace/mode/markdown'

	# # disable scrolling logs in console
	# editor.$blockScrolling = Infinity

	# # editor options
	# editor.setOptions
		# enableBasicAutocompletion: true
		# enableSnippets: true
		# wrap: 100
	
$(document).on('page:load', initEditor)
$(document).ready(initEditor)