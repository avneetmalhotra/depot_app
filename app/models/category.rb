class Category < ApplicationRecord
  ## ASSOCIATIONS
  has_many :categorizations
  # getting all the products which belong to category
  has_many :products, through: :categorizations, dependent: :restrict_with_error
  
  # getting all the sub_categories of the category
  has_many :sub_categories, class_name: 'Category', foreign_key: :root_category_id, dependent: :destroy
  belongs_to :root_category, class_name: 'Category', optional: true

  # getting all the products which belong to subcategories of a given category
  has_many :sub_products, through: :sub_categories, source: :products

  ##VALIDATIONS
  validates :name, presence: true

  # All root category names should be unique
  # For each category, name of its sub_categories should be unique
  validates :name, uniqueness: {
    allow_blank: true,
    scope: :root_category_id,
    case_sensitive: false,
    message: "cannot be used. It is already a sub-category name."
  }, if: :is_sub_category?

  # sub category cannot have any child category. means it is only one level of nesting.
  validate :one_level_nesting, if: :is_sub_category?

  public

    def is_sub_category?
      root_category.present?
    end

    private

    def one_level_nesting
      errors[:base] << 'Only one level nesting allowed' unless root_category.is_root_category?
    end

end
