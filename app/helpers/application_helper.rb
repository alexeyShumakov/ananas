module ApplicationHelper
  def to_markdown(text)
    Kramdown::Document.new(text).to_html.html_safe
  end

  def all_categories
    Category.all.order(:created_at)
  end

  def formated_date(model)
    I18n.localize(model.created_at, format: :long)
  end

  def title_prefix
    "Ананас, советы на каждый день | "
  end
end
