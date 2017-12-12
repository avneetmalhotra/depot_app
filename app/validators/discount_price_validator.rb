class DiscountPriceValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:price] << I18n.t('errors.custom_validations.messages.discount_price_more_than_price') unless
      record.price > record.discount_price
  end
end