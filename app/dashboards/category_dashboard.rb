require "administrate/base_dashboard"

class CategoryDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    title: Field::String,
    posts_count: Field::Number,
    posts: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }

  COLLECTION_ATTRIBUTES = [
    :id,
    :title,
    :posts,
    :posts_count,
  ]

  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :posts,
    :posts_count,
    :title,
    :created_at,
    :updated_at,
  ]

  FORM_ATTRIBUTES = [
    :posts,
    :posts_count,
    :title,
  ]

   def display_resource(category)
     "Category ##{category.title}"
   end
end
