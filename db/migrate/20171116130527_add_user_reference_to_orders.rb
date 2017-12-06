class AddUserReferenceToOrders < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :user
  end
end
