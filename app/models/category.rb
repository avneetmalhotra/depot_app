class Category < ApplicationRecord
  has_many :sub_categories, class_name: 'Category', foreign_key: 'root_category_id'
  belongs_to :root_category, class_name: 'Category'

  has_many :categorizations
  has_many :product, through: :categorizations
end
