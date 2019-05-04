class Api::V1::FavoriteCustomerController < ApplicationController

  def show
    merch = Merchant.find(params["merchant_id"])
    # binding.pry
    render json: FavoriteCustomerSerializer.new(merch.fave_customer(merch.id))
  end
end
