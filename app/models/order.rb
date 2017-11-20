class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  belongs_to :user, optional: true

  enum pay_type: {
    "Check"           => 0,
    "Credit card"     => 1,
    "Purchase order"  => 2
  }

  scope :by_date, ->(from_date = Date.today, to_date = Date.today) { where("DATE(created_at) >= ? AND DATE(created_at) <= ?", from_date, to_date) }

  # ...
  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: pay_types.keys

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def total_price
    line_items.inject(0) do |sum, line_item|
      sum + line_item.total_price
    end
  end
end
