module ApplicationHelper
  def to_markdown(text)
    Kramdown::Document.new(text).to_html.html_safe
  end
end
