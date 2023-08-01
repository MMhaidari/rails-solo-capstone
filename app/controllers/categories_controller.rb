class CategoriesController < ApplicationController
  def index
    @categories = current_user.categories
  end

  def new
    @category = Category.new
  end

end
