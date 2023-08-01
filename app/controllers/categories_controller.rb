class CategoriesController < ApplicationController
  def index
    @categories = current_user.categories
  end

  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    @category.user = current_user

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path, notice: 'Category created successfully!' }
        format.json { render json: @category, status: :created }
      else
        puts @category.errors.full_messages
        format.html { render :new, flash: { error: 'Category not created!' } }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
