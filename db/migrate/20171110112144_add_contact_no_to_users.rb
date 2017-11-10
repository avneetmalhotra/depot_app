class AddContactNoToUsers < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :contact_number, :string, limit: 10
  end
end
