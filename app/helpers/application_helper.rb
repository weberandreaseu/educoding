module ApplicationHelper
  def markdown(text)
    # options and extensions at https://github.com/vmg/redcarpet
    options = {}
    extensions = {fenced_code_blocks: true, tables: true}

    renderer = TaskRender.new(options)
    @markdown ||= Redcarpet::Markdown.new(renderer, extensions)
    @markdown.render(text).html_safe
  end

  def get_class_file_id(class_file)
    if class_file.object.id.nil?
      File.basename( class_file.object.filename, ".*" )
    else
      class_file.object.id
    end
  end
end