<% @solution.run %>
$('#stdout').html('<%= simple_format(@solution.stdout) %>')
$('#compiler_message').empty().append('<%= simple_format(@solution.compiler_message.html_safe) %>')
$('#test_results').html('<table class="table" id="test_summary"></table><div id="testcases" class="row"></div>')
<% root = @solution.basic.at('testsuite') %>
<% root.each do |key, value| %>
$('#test_summary').append('<th><%= "#{key.humanize}: #{value}" %></th>')
<% end %>
<% root.css('testcase').each do |testcase| %>
<% testcase.at_css("failure") ? error_message = testcase.at_css("failure")["message"] : error_message = nil %>
$('#testcases').append( """<div class="col-md-4"><div class="card card-block <%= error_message ? 'card-outline-danger' : 'card-outline-success' %>">
<h5 class="card-title"><%= testcase["name"].underscore.humanize %></h5>
<p class="card-text"><%= error_message ? error_message : 'Passed successfully' %></p>
<small class="text-muted">Time: <%= testcase["time"] %></small>
</div></div> """)
<% end %>