<% result = @solution.run %>
$('#stdout').append("<%= simple_format(result.stdout) %>")
$('#compiler_message').append('<%= simple_format(result.compiler_message.html_safe)%>')