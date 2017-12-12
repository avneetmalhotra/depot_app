class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :user_id, uniqueness: {
    scope: :product_id
  }

  validates :rating, numericality: { 
    greater_than_or_equal_to: 0.0,
    less_than_or_equal_to: 5.0
  }

end
