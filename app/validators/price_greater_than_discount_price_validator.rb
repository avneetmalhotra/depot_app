class PriceGreaterThanDiscountPriceValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:price] << 'must be greater than discount price' unless
      record.price > record.discount_price
  end
end