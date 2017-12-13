class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.decimal :value, precision: 2, scale: 1
      t.references :user
      t.references :product

      t.timestamp
    end
  end
end
