class Picture < ActiveRecord::Base
  has_attached_file :image
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_size :image, less_than: 10.megabytes
  def image_url
    image.url
  end
end
