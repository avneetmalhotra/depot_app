class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product, optional: true
  belongs_to :cart, counter_cache: true

  validates :product_id, uniqueness: {
    scope: :cart_id,
    message: 'already added to a cart' }, unless: :cart_id_nil?

  def total_price
    product.price * quantity
  end

  def cart_id_nil?
    cart_id.nil?
  end
end
