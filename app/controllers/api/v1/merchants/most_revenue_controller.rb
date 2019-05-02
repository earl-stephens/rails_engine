class Api::V1::Merchants::MostRevenueController < ApplicationController

  def index

    render json: MerchantSerializer.new(Merchant.top_merch_by_revenue(params[:quantity]))
    # binding.pry
  end

end
