class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :name
      t.string :file_path

      t.references :product

      t.timestamp
    end
  end
end
