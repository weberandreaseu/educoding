<% result = @solution.run %>
<% test = result.test %>
$('#stdout').html("<%= simple_format(result.stdout) %>")
$('#compiler_message').empty().append('<%= simple_format(result.compiler_message.html_safe)%>')
$('#test_results').html("<div id='testcases' class='row'></div>")

<% test['testcase'].each do |testcase| %>
<% if testcase['failure'] %>
$('#testcases').append("<div class='testcase danger col-md-4'><h6><%= testcase['name'].underscore.humanize%></h6><small>Time: <%= testcase['time'] %></small></br><small>Message: <%= testcase['failure']['message'] %></small></div>")
<% else %>
$('#testcases').append("<div class='testcase success col-md-4'><h6><%= testcase['name'].underscore.humanize%></h6><small>Time: <%= testcase['time'] %></small></div>")
<% end %>
<% end %>

$('#test_results').append("\
<table class='table'>\
  <tr>\
    <td>Tests: <%= test['tests'] %></td>\
    <td>Skipped: <%= test['skipped'] %></td>\
    <td>Failures: <%= test['failures'] %></td>\
    <td>Errors: <%= test['errors'] %></td>\
    <td>Time: <%= test['time'] %></td>\
  </tr>\
</table>\
")