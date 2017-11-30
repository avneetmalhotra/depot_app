class Image < ApplicationRecord
  belongs_to :product

  def uploaded_image=(image_details)
    self.name = image_details.original_filename
    self.content_type = image_details.content_type
    self.data = image_details.read
  end
end