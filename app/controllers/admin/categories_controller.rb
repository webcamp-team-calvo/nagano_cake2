class Admin::CategoriesController < ApplicationController
  
  def new
    @category = Category.new
    @categories = Category.all
  end
end
