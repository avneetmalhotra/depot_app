class Category < ApplicationRecord
  # getting all the sub_categories of the category
  has_many :sub_categories, class_name: 'Category', foreign_key: 'root_category_id'
  belongs_to :root_category, class_name: 'Category', optional: true
  has_many :categorizations
  # getting all the products which belong to category
  has_many :products, through: :categorizations

  # getting all the products which belong to subcategories of a given category
  has_many :sub_products, through: :sub_categories, source: :products

  validates :name, presence: true

  # All root category names should be unique
  validates_uniqueness_of :name, allow_blank: true, case_sensitive: false, message: "is already a Root Category's name", if: :is_root_category?

  # For each category, name of its sub_categories should be unique
  validates :name, uniqueness: {
    allow_blank: true,
    scope: :root_category_id,
    case_sensitive: false,
    message: "cannot be used. It is already a sub-category name."
  }, if: :sub_category?

  # sub category cannot have any child category. means it is only one level of nesting.
  validate :one_level_nesting, if: :is_root_category_id_valid?


  private

  def is_root_category?
    debugger
    root_category_id.nil?
  end

  def sub_category?
    root_category_id.present?
  end

  def one_level_nesting
    errors[:base] << 'Only one level nesting allowed' unless self.root_category.root_category.nil?
  end

  def is_root_category_id_valid?
    unless self.class.ids.include?(root_category_id)
      errors.add(:root_category_id, 'is invalid') 
      return false    
    end
    true
  end

end
