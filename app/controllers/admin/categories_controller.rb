class Admin::CategoriesController < AdminController

  def index
    @categories = Category.includes(:root_category)
  end
end