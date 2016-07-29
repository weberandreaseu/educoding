<% @solution.run %>
$('#stdout').html('<%= simple_format(@solution.stdout) %>')
$('#compiler_message').append('<%= simple_format(@solution.compiler_message.html_safe) %>')
$('#test_results').html("<div id='testcases' class='row'></div>")