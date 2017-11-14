class Product < ApplicationRecord
  include ActiveModel::Validations

  has_many :line_items
  has_many :orders, through: :line_items

  before_destroy :ensure_not_referenced_by_any_line_item
  
  before_validation :initialize_title_with_default_value, if: :title_present?
  
  before_save do
    self.discount_price = price if discount_price.blank?
  end

  ## title's unique validation removed because default value is assigned
  # validates :title, uniqueness: true
  
  with_options presence: true do |product|
    product.validates :price, :permalink, :description, :image_url
  end

  #..
  ## using custom validator
  validates :price, allow_blank: true, numericality: { greater_than_or_equal_to: 0.01 }
  validates_with  PriceGreaterThanDiscountPriceValidator , if: :discount_price_present?
  
  ## using validator method
  # validates :price, allow_blank: true, numericality: { greater_than_or_equal_to: 0.01 }
  # validate :price_must_be_greater_than_discount_price, if: :discount_price_present? 

  #..
  ## title validations
  validates :permalink, uniqueness: true
  validates :permalink, allow_blank: true, format: {
    with: VALID_PERMALINK_REGEX
  }

  ## description validations
  validates :description, allow_blank: true, format: {
    with: VALID_DESCRIPTION_REGEX,
    message: 'can have 5 to 10 words only.'
  }
  
  ## image_url validations
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

    def initialize_title_with_default_value
      self.title = 'abc'
    end

    def discount_price_present?
      discount_price.present?
    end

    def title_present?
      title.present?
    end
end
