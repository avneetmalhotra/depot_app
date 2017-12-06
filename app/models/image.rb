class Image < ApplicationRecord
  belongs_to :product

  def uploaded_image=(image_details)
    self.name = image_details.original_filename
    self.file_path = "/uploads/#{name}"
    save_image(image_details)
  end

  private

  def save_image(image_io)
    File.open(Rails.root.join('public', 'uploads', name), 'wb') do |file|
      file.write(image_io.read)
    end
  end
end