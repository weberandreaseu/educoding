<% result = @solution.run %>
$('#stdout').html("<%= simple_format(result.stdout) %>")
$('#compiler_message').empty().append('<%= simple_format(result.compiler_message.html_safe)%>')