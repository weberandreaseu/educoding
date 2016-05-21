//= require ace/base
//= require ace/markdown

$(document).ready(function() {
	var editor = ace.edit("editor");
	editor.setTheme("ace/theme/chrome");
	editor.getSession().setMode("ace/mode/markdown");

	// disable scroll messages in console
	editor.$blockScrolling = Infinity;

	editor.setOptions({
		enableBasicAutocompletion: true,
		enableSnippets: true
	});

	$('#new-task').click(function() {
		var description = editor.getValue();
		$('#task_description').val(description);
	});
});