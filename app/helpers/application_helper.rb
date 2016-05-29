module ApplicationHelper

  # the markdown parser
  def markdown(text)
    # options an extensions at https://github.com/vmg/redcarpet
    options = {}
    extensions ={}    

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end

  # generates the title for a view depending on action name
  def generate_title(model)
    if action_name == "index"
      model_name = model.class.model_name.human(count: 2)
    else
      model_name = model.class.model_name.human
    end
    t("helpers.title.#{action_name}", model: model_name)
  end
end