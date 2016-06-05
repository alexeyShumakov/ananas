module ApplicationHelper
  include TextHelper

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
