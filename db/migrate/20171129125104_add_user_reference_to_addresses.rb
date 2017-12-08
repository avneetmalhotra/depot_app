class AddUserReferenceToAddresses < ActiveRecord::Migration[5.1]
  def change
    add_reference :addresses, :user
  end
end
