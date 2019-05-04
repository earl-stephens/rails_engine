class Api::V1::FavoriteMerchantController < ApplicationController

  def show
    customer = Customer.find(params[:customer_id])
    render json: FavoriteMerchantSerializer.new(customer.fave_merchant(customer.id))
  end

end
