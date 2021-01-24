class Public::DeliveriesController < ApplicationController

  before_action :authenticate_customer!


  def index
    @delivery = Delivery.new
    @deliveries = current_customer.deliveries
  end

  def edit
    @delivery = Delivery.find(params[:id])
  end

  def create
    @deliveries = current_customer.deliveries.new(delivery_params)
    if @deliveries.save
      redirect_to deliveries_path
    else
      render :index
      @deliveries = current_customer.deliveries
    end
  end

  def update
    @delivery = Delivery.find(params[:id])
    if @delivery.update(delivery_params)
      redirect_to deliveries_path
    else
      render :edit
    end
  end

  def destroy
    @delivery = Delivery.find(params[:id])
    @delivery.destroy
    redirect_to deliveries_path
  end

  protected

  def delivery_params
    params.require(:delivery).permit(:name, :postcode, :address)
  end

end