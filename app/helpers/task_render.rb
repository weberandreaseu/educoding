class TaskRender < Redcarpet::Render::HTML
  # syntax highlighting based on redcarpet documentation
  def block_code(code, language)
    language ? Pygments.highlight(code, lexer: language) : "<pre>#{code}</pre>"
  end

  def table(header, body)
    "<div class=\"table-responsive\"> \
      <table class=\"table table-bordered\"> \
        <thead class=\"thead-default\">#{header}</thead> \
        <tbody>#{body}</tbody> \
      </table> \
    </div>"
  end
end