module ApplicationHelper
  def to_markdown(text)
    Kramdown::Document.new(text).to_html.html_safe
  end
  
  def all_categories
    Category.all.order(:created_at)
  end
end
