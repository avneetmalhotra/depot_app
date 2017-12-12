class ImageUrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << I18n.t('errors.custom_validations.messages.image_url') unless 
      value =~ VALID_IMAGE_URL_VALIDATOR
  end
end