class Product < ApplicationRecord
  has_many :line_items, dependent: :restrict_with_error
  has_many :orders, through: :line_items
  has_many :carts, through: :line_items
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations

  before_validation :initialize_title_with_default_value, unless: :title_present?
  
  before_save :set_discount_price_to_price, unless: :discount_price_present?

  ## title's unique validation removed because default value is assigned
  # validates :title, uniqueness: true
  
  with_options presence: true do
    validates :price, :permalink, :description, :image_url
  end

  #..
  ## using custom validator
  validates :price, allow_blank: true, numericality: { greater_than_or_equal_to: 0.01 }
  validates_with DiscountPriceValidator , if: :discount_price_present?
  
  ## using validator method
  # validates :price, allow_blank: true, numericality: { greater_than_or_equal_to: 0.01 }
  # validate :price_must_be_greater_than_discount_price, if: :discount_price_present? 

  #..
  ## title validations
  validates :permalink, uniqueness: true, allow_blank: true, format: {
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

    def price_must_be_greater_than_discount_price
      errors.add(:price, 'must be greater than discount price') unless 
        price > discount_price
    end

    def initialize_title_with_default_value
      self.title = PRODUCT_TITLE_DEFAULT_VALUE
    end

    def discount_price_present?
      discount_price.present?
    end

    def title_present?
      title.present?
    end

    def set_discount_price_to_price
      self.discount_price = price
    end
end
