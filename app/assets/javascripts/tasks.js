//= require ace-rails-ap
//= require ace/theme-chrome
//= require ace/mode-java
//= require ace/mode-markdown

$(document).ready(function() {
	var editor = ace.edit("editor");
	editor.setTheme("ace/theme/chrome");
	editor.getSession().setMode("ace/mode/markdown");

	$('#new-task').click(function() {
		var description = editor.getValue();
		$('#task_description').val(description);
	});
});