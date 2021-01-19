class Admin::CategoriesController < ApplicationController
  
  def new
    @category = Category.new
    @categories = Category.all
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    category = Category.find(params[:id])
    category.update(category_params)
    redirect_to new_admin_category_path
  end
end
