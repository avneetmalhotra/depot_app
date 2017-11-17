class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  belongs_to :user, optional: true

  enum pay_type: {
    "Check"           => 0,
    "Credit card"     => 1,
    "Purchase order"  => 2
  }
  # ...
  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: pay_types.keys

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def add_logged_in_user_id(user_id)
    self.user_id = user_id unless user_id.nil?
  end

  def total_price
    price = 0
    line_items.each do |line_item|
      price += line_item.total_price
    end
    price
  end
end
