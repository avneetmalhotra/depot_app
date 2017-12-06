class Categorization < ApplicationRecord
  belongs_to :product
  belongs_to :category

  after_save :increment_products_count
  before_destroy :decrement_products_count

  public

    def root_category_id
      is_sub_category_saved?
    end

    def is_sub_category_saved?
      Category.find_by(id: category_id).root_category_id
    end

  private
  
    def increment_products_count
      if is_sub_category_saved?
        Category.increment_counter(:products_count, root_category_id)
      end
      Category.increment_counter(:products_count, category_id)
    end

    def decrement_products_count
      if is_sub_category_saved?
        Category.decrement_counter(:products_count, root_category_id)
      end
      Category.decrement_counter(:products_count, category_id)
    end
end
