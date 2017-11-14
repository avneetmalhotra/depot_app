class ImageUrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << 'must be a URL for GIF, JPG or PNG image.' unless 
      value =~ /\.(gif|jpg|png)\Z/i
  end
end