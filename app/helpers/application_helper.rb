module ApplicationHelper
  def markdown(text)
    # options an extensions at https://github.com/vmg/redcarpet
    options = {}
    extensions ={}    

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end
end

