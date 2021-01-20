class Admin::CustomersController < ApplicationController

  def index
    @customers = Customer.page(params[:page])
  end
end
