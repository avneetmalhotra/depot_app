class ImageUrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << 'must be a URL for GIF, JPG or PNG image.' unless 
      value =~ VALID_IMAGE_URL_VALIDATOR
  end
end