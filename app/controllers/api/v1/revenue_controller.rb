class Api::V1::RevenueController < ApplicationController

  def show
    # binding.pry
    render json: Merchant.find(params[:merchant_id]).total_revenue(Merchant.find(params[:merchant_id]).id)
  end

end
