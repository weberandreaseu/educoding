module ApplicationHelper
 # the markdown parser
  def markdown(text)
    # options and extensions at https://github.com/vmg/redcarpet
    options = {}
    extensions = {fenced_code_blocks: true}

    renderer = Redcarpet::Render::HTML.new(options)
    @markdown ||= Redcarpet::Markdown.new(renderer, extensions)

    @markdown.render(text).html_safe
  end
end