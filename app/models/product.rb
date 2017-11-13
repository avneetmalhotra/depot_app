class ImageUrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << 'must be a URL for GIF, JPG or PNG image.' unless 
      value =~ /\.(gif|jpg|png)\Z/i
  end
end

class PriceGreaterThanDiscountPriceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << 'must be greater than discount price' unless
      value > record.discount_price
  end
end

class Product < ApplicationRecord
  has_many :line_items
  has_many :orders, through: :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  #...
  validates :title, :description, :image_url, :price, :permalink, :discount_price, presence: true
  validates :title, :permalink, uniqueness: true

  #using custom validator
  validates :price, allow_blank: true, numericality: { greater_than_or_equal_to: 0.01 },
    price_greater_than_discount_price: true, if: Proc.new{ |product| product.discount_price.present? }
  
  # using validator method
  validates :price, allow_blank: true, numericality: { greater_than_or_equal_to: 0.01 }
  validate :price_must_be_greater_than_discount_price, if: Proc.new{ |product| product.discount_price.present? } 

  #..
  validates :permalink, allow_blank: true, format: {
    with: /[a-zA-Z0-9]*(\w+-){2,}[a-zA-Z0-9]+/,
    message: 'invalid'
  }

  validates :description, allow_blank: true, length: {in: 5..10}
  validates :image_url, allow_blank: true, image_url: true

  private
  
    # ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      unless line_items.empty?
        errors.add(:base, 'Line Items present')
        throw :abort
      end
    end

    def price_must_be_greater_than_discount_price
      errors.add(:price, 'must be greater than discount price') unless 
        price > discount_price
    end
end
