class AddLineItemsToCart < ActiveRecord::Migration[5.1]
  def change
    add_column :carts, :line_items, :integer, default: 0, null: false
  end
end
