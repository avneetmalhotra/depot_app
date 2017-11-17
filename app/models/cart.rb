class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy,  after_add: :increment_line_items_count, 
    after_remove: :decrement_line_items_count
  # has_many :products, through: :line_items
  has_many :products, -> { where(enabled: true) }, through: :line_items

  def add_product(product)
    current_item = line_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product.id)
    end
    current_item
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  private

    def increment_line_items_count(line_item)
      self.line_items_count += 1
      self.save
    end

    def decrement_line_items_count(line_item)
      self.line_items_count -= 1
      self.save
    end
end
