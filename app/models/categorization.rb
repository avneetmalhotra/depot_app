class Categorization < ApplicationRecord
  belongs_to :product
  belongs_to :category

  after_commit :increment_products_count, on: [:create, :update]
  after_commit :decrement_products_count, on: [:destroy]

  private
  
    def increment_products_count
      if category.is_sub_category?
        Category.increment_counter(:products_count, category.root_category_id)
      end
      Category.increment_counter(:products_count, category_id)
    end

    def decrement_products_count
      if category.is_sub_category?
        Category.decrement_counter(:products_count, category.root_category_id)
      end
      Category.decrement_counter(:products_count, category_id)
    end
end
