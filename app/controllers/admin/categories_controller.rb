class Admin::CategoriesController < Admin::BaseController

  def index
    @categories = Category.includes(:root_category)
  end
end