class CategoriesController < ApplicationController
  def index
    @categories = current_user.categories.includes(:transaction_entries)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.user = current_user

    if @category.save
      redirect_to categories_path, notice: 'Category created successfully!'
    else
      puts @category.errors.full_messages
      flash.now[:error] = 'Category not created!'
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
