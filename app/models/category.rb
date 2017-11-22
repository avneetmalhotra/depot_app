class Category < ApplicationRecord
  # getting all the sub_categories of the category
  has_many :sub_categories, class_name: 'Category', foreign_key: 'root_category_id', dependent: :destroy
  belongs_to :root_category, class_name: 'Category', optional: true
  has_many :categorizations
  # getting all the products which belong to category
  has_many :products, through: :categorizations

  # getting all the products which belong to subcategories of a given category
  has_many :sub_products, through: :sub_categories, source: :products

  validates :name, presence: true

  # All root category names should be unique
  validates_uniqueness_of :name, allow_blank: true, case_sensitive: false, if: :is_root_category?

  # For each category, name of its sub_categories should be unique
  validates :name, uniqueness: {
    allow_blank: true,
    scope: :root_category_id,
    case_sensitive: false,
    message: "cannot be used. It is already a sub-category name."
  }, if: :sub_category?

  # sub category cannot have any child category. means it is only one level of nesting.
  validate :one_level_nesting, if: :sub_category?

  # Should not be able to destroy category if any products are associated with it
  before_destroy :ensure_no_associated_product

  # Should not be able to destroy category if any products are associated with its sub_categories.
  before_destroy :ensure_no_associated_product_with_sub_categories, if: :is_root_category?

  private

  def is_root_category?
    root_category.nil?
  end

  def sub_category?
    root_category.present?
  end

  def one_level_nesting
    errors[:base] << 'Only one level nesting allowed' unless self.root_category.root_category.nil?
  end

  def ensure_no_associated_product
    if products.present?
      errors[:base] << 'Category cannot be deleted. It has associated products.'
      throw :abort
    end 
  end

  def ensure_no_associated_product_with_sub_categories
    if sub_categories.present?
      sub_categories.each do |sub_category|
        if sub_category.products.any?
          errors[:base] << "Category cannot be deleted. It's sub-categories have associated products"
        end
      end
    end
  end

end
