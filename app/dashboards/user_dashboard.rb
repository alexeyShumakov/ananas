require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard

  ATTRIBUTE_TYPES = {
    posts: Field::HasMany,
    comments: Field::HasMany,
    id: Field::Number,
    role: Field::String.with_options(searchable: false),
    email: Field::String,
    is_admin: Field::Boolean,
    encrypted_password: Field::String,
    reset_password_token: Field::String,
    reset_password_sent_at: Field::DateTime,
    remember_created_at: Field::DateTime,
    sign_in_count: Field::Number,
    current_sign_in_at: Field::DateTime,
    last_sign_in_at: Field::DateTime,
    current_sign_in_ip: Field::String.with_options(searchable: false),
    last_sign_in_ip: Field::String.with_options(searchable: false),
    confirmation_token: Field::String,
    confirmed_at: Field::DateTime,
    confirmation_sent_at: Field::DateTime,
    unconfirmed_email: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }

  COLLECTION_ATTRIBUTES = [
    :id,
    :email,
    :role,
    :is_admin
  ]

  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :posts,
    :comments,
    :role,
    :is_admin,
    :email,
    :created_at,
    :updated_at
  ]

  FORM_ATTRIBUTES = [
    :posts,
    :comments,
    :email,
    :role,
    :is_admin
  ]

   def display_resource(user)
     "User ##{user.email}"
   end
end
