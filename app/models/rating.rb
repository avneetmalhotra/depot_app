class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :user_id, uniqueness: {
    scope: :product_id
  }

  validates :value, numericality: { 
    greater_than_or_equal_to: 0.0,
    less_than_or_equal_to: 5.0
  }

  def add_logged_in_user_id(user)
    self.user_id = user.id
  end

  def add_associated_product_id(product_id)
    self.product_id = product_id
  end
end
